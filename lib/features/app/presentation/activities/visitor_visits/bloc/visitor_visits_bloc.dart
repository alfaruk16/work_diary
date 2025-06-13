import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/change_visit_status.dart';
import 'package:work_diary/features/app/data/models/todays_visit.dart';
import 'package:work_diary/features/app/data/models/user_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_pagination.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';
import 'package:work_diary/features/app/domain/entities/update_visit.dart';
import 'package:work_diary/features/app/domain/entities/user_profile.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/completed_visit_plan/view/completed_visit_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/incomplete_visit/view/incomplete_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/view/ongoing_visit_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/postpone/view/postpone_screen.dart';
import 'package:work_diary/features/app/presentation/activities/visit_cancelled/view/visit_cancelled_screen.dart';
import 'package:work_diary/features/app/presentation/activities/visit_details/view/visit_details_screen.dart';

import '../../emergency_issue/widgets/change_status.dart';

part 'visitor_visits_event.dart';
part 'visitor_visits_state.dart';

class VisitorVisitsBloc extends Bloc<VisitorVisitsEvent, VisitorVisitsState> {
  VisitorVisitsBloc(
      this._apiRepo, this._localStorageRepo, this._iFlutterNavigator)
      : super(VisitorVisitsInitial()) {
    on<IsSupervisor>(_isSupervisor);
    on<GetDataById>(_getDataById);
    on<GetvisitById>(_getvisitById);
    on<PageIncrement>(_pageIncrement);
    on<GoToPlanList>(_goToPlanList);
    on<GetComments>(_getComments);
    on<UpdateStatus>(_updateStatus);
    on<UpdateVisitItem>(_updateVisitItem);
    on<GoToDashboard>(_goToDashboard);
  }

  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _isSupervisor(
      IsSupervisor event, Emitter<VisitorVisitsState> emit) async {
    emit(state.copyWith(
        isSupervisor:
            await LocalData.isSupervisor(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _getDataById(
      GetDataById event, Emitter<VisitorVisitsState> emit) async {
    emit(state.copyWith(visitorDetails: event.userDetails));

    final visitor = await _apiRepo.post(
      endpoint: userProfileEndpoint,
      body: UserId(userId: state.visitorDetails.data!.id!, related: false),
      responseModel: const UserDetails(),
    );
    if (visitor != null) {
      emit(state.copyWith(visitorDetails: visitor));
    }
    add(GetvisitById(id: state.visitorDetails.data!.id!));
  }

  FutureOr<void> _getvisitById(
      GetvisitById event, Emitter<VisitorVisitsState> emit) async {
    if (!state.isLoading) {
      emit(state.copyWith(isLoading: true, page: 1, isEndList: false));

      final thisMonthStart = DateFormat("yyyy-MM-dd")
          .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

      final thisMonthEnd = DateFormat("yyyy-MM-dd")
          .format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

      final visitSResponse = await _apiRepo.post(
        endpoint: getVisitsEndpoint,
        body: TodaysVisits(
          companyId:
              await LocalData.getCompanyId(localStorageRepo: _localStorageRepo),
          dateFor: "$thisMonthStart|$thisMonthEnd",
          visitorId: state.visitorDetails.data!.id!,
        ),
        responseModel: const TodaysVisitResponse(),
      );

      if (visitSResponse != null) {
        emit(state.copyWith(visits: visitSResponse));
      }
      emit(state.copyWith(isLoading: false));
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<VisitorVisitsState> emit) async {
    final thisMonthStart = DateFormat("yyyy-MM-dd")
        .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

    final thisMonthEnd = DateFormat("yyyy-MM-dd")
        .format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0));

    int totalPage = state.page + 1;
    if (totalPage <= state.visits.meta!.lastPage!) {
      if (!state.isLoading) {
        emit(state.copyWith(isLoading: true, page: totalPage));

        final visitPagination = await _apiRepo.post(
          endpoint: "$getVisitsEndpoint?page=${state.page}",
          body: TodaysVisits(
            dateFor: '$thisMonthStart|$thisMonthEnd',
            visitorId: state.visitorDetails.data!.id!,
          ),
          responseModel: const TodaysVisitPagination(),
        );

        emit(state.copyWith(isLoading: false));

        if (visitPagination != null) {
          emit(state.copyWith(
              visits: TodaysVisitResponse(
                  data: state.visits.data! + visitPagination.data!,
                  meta: visitPagination.meta!,
                  ongoing: state.visits.ongoing,
                  summery: state.visits.summery)));
        }
      }
    } else if (!state.isLoading) {
      emit(state.copyWith(isEndList: true));
    }
  }

  FutureOr<void> _goToPlanList(
      GoToPlanList event, Emitter<VisitorVisitsState> emit) {
    if (event.planType == "Completed") {
      _iFlutterNavigator
          .push(CompletedVisitPlanScreen.route(visitData: event.visitData));
    } else if (event.planType == "On Going") {
      _iFlutterNavigator
          .push(OngoingVisitPlanScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetDataById(userDetails: state.visitorDetails));
        }
      });
    } else if (event.planType == "Postponed") {
      _iFlutterNavigator.push(PostponeScreen.route());
    } else if (event.planType == "Approved") {
      _iFlutterNavigator
          .push(VisitDetailsScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetDataById(userDetails: state.visitorDetails));
        }
      });
    } else if (event.planType == "Paused") {
      _iFlutterNavigator
          .push(VisitDetailsScreen.route(visitData: event.visitData))
          .then((value) {
        if (value != null) {
          add(GetDataById(userDetails: state.visitorDetails));
        }
      });
    } else if (event.planType == "Waiting For Approval") {
      _iFlutterNavigator
          .push(VisitDetailsScreen.route(visitData: event.visitData));
    } else if (event.planType == "Cancelled") {
      _iFlutterNavigator
          .push(VisitCancelledScreen.route(visitData: event.visitData));
    } else if (event.planType == "Incomplete") {
      _iFlutterNavigator
          .push(IncompleteVisitScreen.route(visitData: event.visitData));
    }
  }

  FutureOr<void> _getComments(
      GetComments event, Emitter<VisitorVisitsState> emit) {
    changeStatus(
      _iFlutterNavigator.context,
      getComment: (value) {
        _iFlutterNavigator.pop();
        add(UpdateStatus(id: event.id, status: event.status, comments: value));
      },
    );
  }

  FutureOr<void> _updateStatus(
      UpdateStatus event, Emitter<VisitorVisitsState> emit) async {
    final statusResponse = await _apiRepo.post(
      endpoint: changeStatusEndpoint,
      body: ChangeVisitStatus(
        visitId: event.id,
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
      UpdateVisitItem event, Emitter<VisitorVisitsState> emit) {
    final list = state.visits.data;
    for (int i = 0; i < state.visits.data!.length; i++) {
      if (state.visits.data![i].id == event.updateVisit.id!) {
        List.from(list!
          ..removeAt(i)
          ..insert(i, event.updateVisit));
        break;
      }
    }

    emit(state.copyWith(
        visits: TodaysVisitResponse(
      data: list,
      meta: state.visits.meta,
      ongoing: state.visits.ongoing,
      summery: state.visits.summery,
    )));
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<VisitorVisitsState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }
}
