import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/change_plan_status.dart';
import 'package:work_diary/features/app/data/models/today_plan.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_pagination.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';
import 'package:work_diary/features/app/domain/entities/update_visit.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/completed_visit_plan/view/completed_visit_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/incomplete_visit/view/incomplete_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/view/ongoing_visit_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/plan_cancelled/view/plan_cancelled_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/plan_details/view/plan_details_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/today_plan_supervisor_state.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/todays_plan_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/postpone/view/postpone_screen.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/widget/change_status.dart';
import 'package:work_diary/features/app/presentation/activities/visit_details/view/visit_details_screen.dart';

class TodaysPlanBlocSupervisor
    extends Bloc<TodaysPlanEvent, TodaysPlanStateSuperVisor> {
  TodaysPlanBlocSupervisor(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(const TodaysPlanStateSuperVisor()) {
    on<GetVisitStatus>(_getVisitStatus);
    on<GetTodaysPlan>(_getTodaysVisitPlan);
    on<SelectedVisitStatus>(_selectedVisitStatus);
    on<SelectedVisitDate>(_selectedVisitDate);
    on<UpdateVisitDate>(_updateVisitDate);
    on<GetComments>(_getComments);
    on<UpdateStatus>(_updateStatus);
    on<PageIncrement>(_pageIncrement);
    on<SetPlanType>(_setPlanListType);
    on<GoToPlanList>(_goToPlanList);
    on<IsSupervisor>(_isSupervisor);
    on<UpdateVisitItem>(_updateVisitItem);
    on<CheckLocal>(_checkLocal);

    add(IsSupervisor());
    add(GetVisitStatus());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isSupervisor(
      IsSupervisor event, Emitter<TodaysPlanStateSuperVisor> emit) async {
    emit(state.copyWith(
        isSupervisor:
            await LocalData.isSupervisor(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _goToPlanList(
      GoToPlanList event, Emitter<TodaysPlanStateSuperVisor> emit) {
    if (event.planType == "Completed") {
      _iFlutterNavigator
          .push(CompletedVisitPlanScreen.route(visitData: event.visitData));
    } else if (event.planType == "On Going") {
      _iFlutterNavigator
          .push(OngoingVisitPlanScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetTodaysPlan());
        }
      });
    } else if (event.planType == "Postponed") {
      _iFlutterNavigator.push(PostponeScreen.route());
    } else if (event.planType == "Approved") {
      _iFlutterNavigator
          .push(PlanDetailsScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetTodaysPlan());
        }
      });
    } else if (event.planType == "Paused") {
      _iFlutterNavigator
          .push(VisitDetailsScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetTodaysPlan());
        }
      });
    } else if (event.planType == "Waiting For Approval") {
      _iFlutterNavigator
          .push(PlanDetailsScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetTodaysPlan());
        }
      });
    } else if (event.planType == "Cancelled") {
      _iFlutterNavigator
          .push(PlanCancelledScreen.route(visitData: event.visitData));
    } else if (event.planType == "Incomplete") {
      _iFlutterNavigator
          .push(IncompleteVisitScreen.route(visitData: event.visitData));
    }
  }

  FutureOr<void> _getVisitStatus(
      GetVisitStatus event, Emitter<TodaysPlanStateSuperVisor> emit) async {
    final visitStatusData = await _localStorageRepo.readModel(
        key: planStatusDB, model: const VisitStatus());

    if (visitStatusData != null) {
      final visitStatus = <DropdownItem>[
        const DropdownItem(name: "Filter by", value: -1)
      ];
      for (int i = 0; i < visitStatusData.data!.length; i++) {
        visitStatus
            .add(DropdownItem(name: visitStatusData.data![i].name!, value: i));
      }
      emit(state.copyWith(
          visitStatus: visitStatusData, visitStatusList: visitStatus));
      emit(state.copyWith(
          selectedStatus: getSelectedStatus(state.selectedVisitStatus)));
    }

    final visitStatusResponse = await _apiRepo.post(
        endpoint: getPlanStatusEndpoint, responseModel: const VisitStatus());

    if (visitStatusResponse != null) {
      final visitStatus = <DropdownItem>[
        const DropdownItem(name: "Filter by", value: -1)
      ];
      for (int i = 0; i < visitStatusResponse.data!.length; i++) {
        visitStatus.add(
            DropdownItem(name: visitStatusResponse.data![i].name!, value: i));
      }
      emit(state.copyWith(
          visitStatus: visitStatusResponse, visitStatusList: visitStatus));
      emit(state.copyWith(
          selectedStatus: getSelectedStatus(state.selectedVisitStatus)));

      _localStorageRepo.writeModel(
          key: planStatusDB, value: visitStatusResponse);
    }
  }

  FutureOr<void> _selectedVisitStatus(
      SelectedVisitStatus event, Emitter<TodaysPlanStateSuperVisor> emit) {
    if (event.selectedIndex != -1) {
      emit(state.copyWith(
          page: 1,
          isEndList: false,
          selectedStatus: event.selectedIndex,
          selectedVisitStatus:
              state.visitStatus.data![event.selectedIndex].value));
    } else {
      emit(state.copyWith(
          selectedVisitStatus: '', selectedStatus: event.selectedIndex));
    }
    add(GetTodaysPlan());
  }

  FutureOr<void> _getTodaysVisitPlan(
      GetTodaysPlan event, Emitter<TodaysPlanStateSuperVisor> emit) async {
    if (!state.isLoading) {
      emit(state.copyWith(isLoading: true, page: 1, isEndList: false));

      final String localDatabaseKey = todayPlanSupervisorDB +
          state.userType +
          state.selectedDate.toString();

      final visitPlanResponse = await _apiRepo.post(
        endpoint: getPlanEndpoint,
        body: TodaysPlan(
            companyId: await LocalData.getCompanyId(
                localStorageRepo: _localStorageRepo),
            dateFor: state.date,
            status: state.selectedVisitStatus,
            plansFor: state.userType),
        responseModel: const TodaysVisitResponse(),
      );

      if (visitPlanResponse != null) {
        emit(state.copyWith(todayVisits: visitPlanResponse));
        _localStorageRepo.writeModel(
            key: localDatabaseKey, value: visitPlanResponse);
      }
      emit(state.copyWith(isLoading: false));
    }
  }

  FutureOr<void> _selectedVisitDate(
      SelectedVisitDate event, Emitter<TodaysPlanStateSuperVisor> emit) {
    if (event.selectedVisitStatus != null) {
      emit(state.copyWith(
          selectedVisitStatus: state.visitStatus.data != null
              ? state.visitStatus
                  .data![getSelectedStatus(event.selectedVisitStatus)].value
              : '',
          selectedStatus: getSelectedStatus(event.selectedVisitStatus)));
    }

    final today = DateFormat("yyyy-MM-dd").format(DateTime.now());

    final tomorrow = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(const Duration(days: 1)));

    lastDays<String>({required int day}) {
      return DateFormat("yyyy-MM-dd")
          .format(DateTime.now().subtract(Duration(days: day)));
    }

    nextDays<String>({required int day}) {
      return DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: day)));
    }

    final thisMonthStart = DateFormat("yyyy-MM-dd")
        .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

    final thisMonthEnd = DateFormat("yyyy-MM-dd")
        .format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

    if (event.selectedIndex == -1) {
      emit(state.copyWith(
        date: '$tomorrow|${nextDays(day: 30)}',
        selectedDate: event.selectedIndex,
        planListType: state.planListType,
      ));
    } else if (event.selectedIndex == 0) {
      emit(state.copyWith(
        date: '$today|$today',
        selectedDate: event.selectedIndex,
        planListType: state.planListType,
      ));
    } else if (event.selectedIndex == 1) {
      emit(state.copyWith(
        date: '${lastDays(day: 1)}|${lastDays(day: 1)}',
        selectedDate: event.selectedIndex,
        planListType: planListTypeValues[PlanListType.upcomingThirty],
      ));
    } else if (event.selectedIndex == 2) {
      emit(state.copyWith(
        date: '${lastDays(day: 7)}|$today',
        selectedDate: event.selectedIndex,
        planListType: planListTypeValues[PlanListType.yesterday],
      ));
    } else if (event.selectedIndex == 3) {
      emit(state.copyWith(
        date: '$thisMonthStart|$thisMonthEnd',
        selectedDate: event.selectedIndex,
        planListType: planListTypeValues[PlanListType.lastSeven],
      ));
    } else if (event.selectedIndex == 4) {
      emit(state.copyWith(
        date: '${lastDays(day: 30)}|$today',
        selectedDate: event.selectedIndex,
        planListType: planListTypeValues[PlanListType.lastThirty],
      ));
    } else if (event.selectedIndex == 5) {
      emit(state.copyWith(
        date: '${lastDays(day: 60)}|$today',
        selectedDate: event.selectedIndex,
        planListType: planListTypeValues[PlanListType.lastSixty],
      ));
    }
    if (event.selectedTab == null || event.selectedTab == 1) {
      add(GetTodaysPlan());
    }
  }

  FutureOr<void> _updateVisitDate(
      UpdateVisitDate event, Emitter<TodaysPlanStateSuperVisor> emit) {
    String result = event.updateDate.replaceAll('|', ' to ');
    emit(state.copyWith(
      date: event.updateDate,
      selectedDate: event.selectedDate,
      planListType: "${planListTypeValues[PlanListType.visitPlanFor]} $result",
    ));
    add(GetTodaysPlan());
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TodaysPlanStateSuperVisor> emit) async {
    int totalPage = state.page + 1;
    if (totalPage <= state.todayVisits.meta!.lastPage!) {
      if (!state.isLoading) {
        emit(state.copyWith(isLoading: true, page: totalPage));

        final visitPagination = await _apiRepo.post(
          endpoint: "$getPlanEndpoint?page=${state.page}",
          body: TodaysPlan(
              dateFor: state.date,
              status: state.selectedVisitStatus,
              plansFor: state.userType),
          responseModel: const TodaysVisitPagination(),
        );

        emit(state.copyWith(isLoading: false));

        if (visitPagination != null) {
          emit(state.copyWith(
              todayVisits: TodaysVisitResponse(
                  data: state.todayVisits.data! + visitPagination.data!,
                  meta: visitPagination.meta!,
                  ongoing: state.todayVisits.ongoing,
                  summery: state.todayVisits.summery)));
        }
      }
    } else if (!state.isLoading) {
      emit(state.copyWith(isEndList: true));
    }
  }

  FutureOr<void> _getComments(
      GetComments event, Emitter<TodaysPlanStateSuperVisor> emit) {
    changeStatus(
      _iFlutterNavigator.context,
      getComment: (value) {
        _iFlutterNavigator.pop();
        add(UpdateStatus(id: event.id, status: event.status, comments: value));
      },
    );
  }

  FutureOr<void> _updateStatus(
      UpdateStatus event, Emitter<TodaysPlanStateSuperVisor> emit) async {
    final statusResponse = await _apiRepo.post(
      endpoint: plansChangeStatusEndpoint,
      body: ChangePlanStatus(
        planId: event.id,
        status: event.status,
        comments: event.comments,
      ),
      responseModel: const UpdateVisit(),
    );
    if (statusResponse != null) {
      add(UpdateVisitItem(updateVisit: statusResponse.data!));
    }
  }

  FutureOr<void> _updateVisitItem(
      UpdateVisitItem event, Emitter<TodaysPlanStateSuperVisor> emit) {
    final list = state.todayVisits.data;
    for (int i = 0; i < state.todayVisits.data!.length; i++) {
      if (state.todayVisits.data![i].id == event.updateVisit.id!) {
        List.from(list!
          ..removeAt(i)
          ..insert(i, event.updateVisit));
        break;
      }
    }

    emit(state.copyWith(
        todayVisits: TodaysVisitResponse(
            data: list,
            meta: state.todayVisits.meta,
            ongoing: state.todayVisits.ongoing,
            summery: state.todayVisits.summery)));
  }

  FutureOr<void> _setPlanListType(
      SetPlanType event, Emitter<TodaysPlanStateSuperVisor> emit) {
    add(SelectedVisitDate(
        selectedIndex: event.selectedDateDropdown,
        selectedVisitStatus: event.status));
    if (event.selectedDateDropdown != null) {
      add(CheckLocal(selectedDateDropdown: event.selectedDateDropdown!));
    }
  }

  FutureOr<void> _checkLocal(
      CheckLocal event, Emitter<TodaysPlanStateSuperVisor> emit) async {
    final String localDatabaseKey = todayPlanSupervisorDB +
        state.userType +
        event.selectedDateDropdown.toString();

    final data = await _localStorageRepo.readModel(
        key: localDatabaseKey, model: const TodaysVisitResponse());

    if (data != null) {
      emit(state.copyWith(todayVisits: data));
    }
  }

  int getSelectedStatus(String? selectedVisitStatus) {
    if (selectedVisitStatus != null && state.visitStatus.data != null) {
      for (int i = 0; i < state.visitStatus.data!.length; i++) {
        if (state.visitStatus.data![i].name == selectedVisitStatus ||
            state.visitStatus.data![i].value == selectedVisitStatus) {
          return i;
        }
      }
    }
    return -1;
  }
}
