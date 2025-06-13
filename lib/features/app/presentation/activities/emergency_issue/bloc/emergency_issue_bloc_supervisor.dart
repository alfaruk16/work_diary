import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/date_picker.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/change_emergency_issue_status.dart';
import 'package:work_diary/features/app/data/models/emergency_task.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_pagination.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_emergency_issue/view/add_new_emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/complete_emergency_issue_details/view/complete_emergency_issue_details_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_state_supervisor.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/view/emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/widgets/change_status.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue_cancelled/view/emergency_issue_cancelled_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue_details/view/emergency_issue_details_screen.dart';

class EmergencyIssueBlocSupervisor
    extends Bloc<EmergencyIssueEvent, EmergencyIssueStateSupervisor> {
  EmergencyIssueBlocSupervisor(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(const EmergencyIssueStateSupervisor()) {
    on<CreateEmergencyIssue>(_createEmergencyIssue);
    on<GetVisitStatus>(_getVisitStatus);
    on<GoToPlanList>(_goToPlanList);
    on<GetTodaysVisitPlan>(_getTodaysVisitPlan);
    on<SelectedVisitStatus>(_selectedVisitStatus);
    on<SelectedVisitDate>(_selectedVisitDate);
    on<UpdateVisiteDate>(_updateVisitDate);
    on<PageIncrement>(_pageIncrement);
    on<GetComments>(_getComments);
    on<UpdateStatus>(_updateStatus);
    on<MenuItemScreens>(_menuItemScreens);
    on<Reload>(_reload);
    on<CheckLocal>(_checkLocal);

    add(GetVisitStatus());
    add(GetTodaysVisitPlan());
    add(CheckLocal());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _createEmergencyIssue(
      CreateEmergencyIssue event, Emitter<EmergencyIssueStateSupervisor> emit) {
    _iFlutterNavigator
        .push(AddNewEmergencyIssueScreen.route())
        .then((value) => add(GetTodaysVisitPlan()));
  }

  FutureOr<void> _goToPlanList(
      GoToPlanList event, Emitter<EmergencyIssueStateSupervisor> emit) {
    if (event.planType == "completed") {
      _iFlutterNavigator
          .push(CompleteEmergencyIssueScreen.route(visitData: event.visitData));
    } else if (event.planType == "pending") {
      _iFlutterNavigator
          .push(EmergencyIssueDetailsScreen.route(visitData: event.visitData))
          .then((value) => add(GetTodaysVisitPlan()));
    } else if (event.planType == "cancelled") {
      _iFlutterNavigator.push(
          EmergencyIssueCancelledScreen.route(visitData: event.visitData));
    }
  }

  //get visit status
  FutureOr<void> _getVisitStatus(
      GetVisitStatus event, Emitter<EmergencyIssueStateSupervisor> emit) async {
    final visitStatus = <DropdownItem>[
      const DropdownItem(name: "Filter by", value: -1)
    ];
    final visitStatusResponse = await _apiRepo.post(
        endpoint: getEmergencyTaskStatusEndpoint,
        responseModel: const VisitStatus());

    if (visitStatusResponse != null) {
      for (int i = 0; i < visitStatusResponse.data!.length; i++) {
        visitStatus.add(
            DropdownItem(name: visitStatusResponse.data![i].name!, value: i));
      }
    }
    emit(state.copyWith(
        visitStatus: visitStatusResponse, visitStatusList: visitStatus));
  }

//Selected visit status
  FutureOr<void> _selectedVisitStatus(
      SelectedVisitStatus event, Emitter<EmergencyIssueStateSupervisor> emit) {
    if (event.selectedIndex != -1) {
      emit(state.copyWith(
          page: 1,
          isEndList: false,
          selectedVisitStatus:
              state.visitStatus.data![event.selectedIndex].value));
    } else {
      emit(state.copyWith(selectedVisitStatus: ''));
    }

    add(GetTodaysVisitPlan());
  }

//Initial visit plans
  FutureOr<void> _getTodaysVisitPlan(GetTodaysVisitPlan event,
      Emitter<EmergencyIssueStateSupervisor> emit) async {
    if (!state.isLoading) {
      emit(state.copyWith(dateList: [
        const DropdownItem(name: 'Next 30 days', value: -1),
        const DropdownItem(name: 'This Month', value: 0),
        const DropdownItem(name: 'Today', value: 1),
        const DropdownItem(name: 'Yesterday', value: 2),
        const DropdownItem(name: "Last 7 days", value: 3),
        const DropdownItem(name: 'Last 30 days', value: 4),
        // const DropdownItem(name: 'Custom Date', value: 5),
      ], isLoading: true, isEndList : false, page: 1));

      final String localDatabaseKey = emergencyIssueSupervisorDB +
          state.userType +
          state.selectedDate.toString();

      final visitPlanResponse = await _apiRepo.post(
        endpoint: getEmergencyTasksEndpoint,
        body: EmergencyTask(
            dateFor: dateForData(),
            status: state.selectedVisitStatus,
            tasksFor: state.userType),
        responseModel: const EmergencyTaskResponse(),
      );

      emit(state.copyWith(isLoading: false));

      if (visitPlanResponse != null) {
        emit(state.copyWith(emergencyIssue: visitPlanResponse));
        _localStorageRepo.writeModel(
            key: localDatabaseKey, value: visitPlanResponse);
      }
    }
  }

// Selected visit date
  FutureOr<void> _selectedVisitDate(
      SelectedVisitDate event, Emitter<EmergencyIssueStateSupervisor> emit) {
    final today = DateFormat("yyyy-MM-dd").format(DateTime.now());

    lastDays<String>({required int day}) {
      return DateFormat("yyyy-MM-dd")
          .format(DateTime.now().subtract(Duration(days: day)));
    }

    final tomorrow = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(const Duration(days: 1)));

    nextDays<String>({required int day}) {
      return DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: day)));
    }

    final thisMonth =
        '${DateFormat("yyyy-MM-dd").format(DateTime(DateTime.now().year, DateTime.now().month, 1))}|${DateFormat("yyyy-MM-dd").format((DateTime(DateTime.now().year, DateTime.now().month + 1, 0)))}';

    emit(state.copyWith(page: 1, isEndList: false));

    if (event.selectedIndex == -1) {
      emit(state.copyWith(
        date: '$tomorrow|${nextDays(day: 30)}',
        selectedDate: event.selectedIndex,
        listForDates: "This Months Emergency Issue",
      ));
    } else if (event.selectedIndex == 0) {
      emit(state.copyWith(
        date: thisMonth,
        selectedDate: event.selectedIndex,
        listForDates: "This Months Emergency Issue",
      ));
    } else if (event.selectedIndex == 1) {
      emit(state.copyWith(
        date: '$today|$today',
        selectedDate: event.selectedIndex,
        listForDates: "Today's Emergency Issue",
      ));
    } else if (event.selectedIndex == 2) {
      emit(state.copyWith(
        date: '${lastDays(day: 1)}|${lastDays(day: 1)}',
        selectedDate: event.selectedIndex,
        listForDates: "Yesterday Emergency Issue",
      ));
    } else if (event.selectedIndex == 3) {
      emit(state.copyWith(
        date: '${lastDays(day: 7)}|$today',
        selectedDate: event.selectedIndex,
        listForDates: "Last 7 Days Emergency Issue",
      ));
    } else if (event.selectedIndex == 4) {
      emit(state.copyWith(
        date: '${lastDays(day: 30)}|$today',
        selectedDate: event.selectedIndex,
        listForDates: "Last 30 Days Emergency Issue",
      ));
    } else if (event.selectedIndex == 5) {
      datePicker(
        _iFlutterNavigator.context,
        // dateSelectionMode: DateRangePickerSelectionMode.range,
        date: (startDate, endDate) {
          String? dateRange =
              "${DateFormat("yyyy-MM-dd").format(startDate)}|${DateFormat("yyyy-MM-dd").format(endDate)}";
          add(UpdateVisiteDate(
              updateDate: dateRange, selectedDate: event.selectedIndex));
        },
      );
    }
    add(GetTodaysVisitPlan()); //today
  }

  FutureOr<void> _updateVisitDate(
      UpdateVisiteDate event, Emitter<EmergencyIssueStateSupervisor> emit) {
    String result = event.updateDate.replaceAll('|', ' to ');
    emit(state.copyWith(
      date: event.updateDate,
      selectedDate: event.selectedDate,
      listForDates: "Emergency Issue For $result",
    ));
    add(GetTodaysVisitPlan());
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<EmergencyIssueStateSupervisor> emit) async {
    int totalPage = state.page + 1;
    if (totalPage <= state.emergencyIssue.meta!.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final visitPagination = await _apiRepo.post(
          endpoint: "$getEmergencyTasksEndpoint?page=${state.page}",
          body: EmergencyTask(
              dateFor: dateForData(),
              status: state.selectedVisitStatus,
              tasksFor: 'as_supervisor'),
          responseModel: const EmergencyTaskPagination(),
        );
        emit(state.copyWith(page: totalPage, incrementLoader: false));
        if (visitPagination != null) {
          emit(state.copyWith(
            emergencyIssue: EmergencyTaskResponse(
                data: state.emergencyIssue.data! + visitPagination.data!,
                meta: visitPagination.meta!,
                summery: state.emergencyIssue.summery),
          ));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }

  dateForData() {
    final String dateForData;
    final thisMonth =
        '${DateFormat("yyyy-MM-dd").format(DateTime(DateTime.now().year, DateTime.now().month, 1))}|${DateFormat("yyyy-MM-dd").format((DateTime(DateTime.now().year, DateTime.now().month + 1, 0)))}';

    if (state.date.isEmpty) {
      dateForData = thisMonth;
      return dateForData;
    } else {
      return dateForData = state.date;
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<EmergencyIssueStateSupervisor> emit) {
    if (event.name == PopUpMenu.addNewEmergencyIssue.name) {
      _iFlutterNavigator
          .push(AddNewEmergencyIssueScreen.route())
          .then((value) => add(GetTodaysVisitPlan()));
    } else if (event.name == PopUpMenu.allEmergencyIssue.name) {
      _iFlutterNavigator.push(EmergencyIssueScreen.route());
    } else if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.pop();
    }
  }

  FutureOr<void> _reload(
      Reload event, Emitter<EmergencyIssueStateSupervisor> emit) {
    emit(state.copyWith(page: 1));
    add(GetTodaysVisitPlan());
  }

  FutureOr<void> _getComments(
      GetComments event, Emitter<EmergencyIssueStateSupervisor> emit) {
    changeStatus(
      _iFlutterNavigator.context,
      getComment: (value) {
        _iFlutterNavigator.pop();
        add(UpdateStatus(id: event.id, status: event.status, comments: value));
      },
    );
  }

  FutureOr<void> _updateStatus(
      UpdateStatus event, Emitter<EmergencyIssueStateSupervisor> emit) async {
    final statusResponse = await _apiRepo.post(
      endpoint: emergencyTasksChangeStatusEndpoint,
      body: ChangeEmergencyIssueStatus(
        emergencyTaskId: event.id,
        status: event.status,
        comments: event.comments,
      ),
      responseModel: const DefaultResponse(),
    );
    if (statusResponse != null) {
      add(GetTodaysVisitPlan());
    }
  }

  FutureOr<void> _checkLocal(
      CheckLocal event, Emitter<EmergencyIssueStateSupervisor> emit) async {
    final String localDatabaseKey = emergencyIssueSupervisorDB +
        state.userType +
        state.selectedDate.toString();

    final data = await _localStorageRepo.readModel(
        key: localDatabaseKey, model: const EmergencyTaskResponse());
    if (data != null) {
      emit(state.copyWith(emergencyIssue: data));
    }
  }
}
