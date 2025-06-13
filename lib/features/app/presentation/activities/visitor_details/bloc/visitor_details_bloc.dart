import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/chart_model.dart';
import 'package:work_diary/features/app/data/models/user_id.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/performance_report/view/performance_report_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan/view/add_new_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_visits/view/visitor_visits_screen.dart';

part 'visitor_details_event.dart';
part 'visitor_details_state.dart';

class VisitorDetailsBloc
    extends Bloc<VisitorDetailsEvent, VisitorDetailsState> {
  VisitorDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(VisitorDetailsInitial()) {
    on<GetDetailsById>(_getDetailsById);
    on<GetChartById>(_getChartById);
    on<GoToVisitorVisitsScreen>(_goToVisitorVisitsScreen);
    on<GoToDashboard>(_goToDashboard);
    on<GoToPerformanceReport>(_goToPerformanceReport);
    on<AssignVisit>(_assignVisit);
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getDetailsById(
      GetDetailsById event, Emitter<VisitorDetailsState> emit) async {
    final user = event.visitorInfo;
    emit(state.copyWith(
        pageLoader: true,
        visitorDetails: UserDetails(
            data: UserData(
                id: user.id,
                code: user.code,
                role: user.role,
                name: user.name,
                email: user.email,
                mobile: user.mobile,
                avatar: user.avatar,
                designation: user.designation,
                department: user.department))));

    final visitor = await _apiRepo.post(
      endpoint: userProfileEndpoint,
      body: UserId(userId: event.visitorInfo.id!, related: false),
      responseModel: const UserDetails(),
    );

    if (visitor != null) {
      emit(state.copyWith(visitorDetails: visitor));
    }

    add(GetChartById(id: state.visitorDetails.data!.id!));
    emit(state.copyWith(pageLoader: false));
  }

  FutureOr<void> _getChartById(
      GetChartById event, Emitter<VisitorDetailsState> emit) async {
    final chartResponse = await _apiRepo.post(
      endpoint: dashboardChartGetEndpoint,
      body: ChartModel(visitorId: event.id),
      responseModel: const ChartResponse(),
    );
    if (chartResponse != null) {
      emit(state.copyWith(chart: chartResponse));
    }
  }

  FutureOr<void> _goToVisitorVisitsScreen(
      GoToVisitorVisitsScreen event, Emitter<VisitorDetailsState> emit) {
    _iFlutterNavigator
        .push(VisitorVisitsScreen.route(userDetails: event.userDetails));
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<VisitorDetailsState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  FutureOr<void> _goToPerformanceReport(
      GoToPerformanceReport event, Emitter<VisitorDetailsState> emit) {
    _iFlutterNavigator
        .push(PerformanceReportScreen.route(visitor: state.visitorDetails));
  }

  Future<FutureOr<void>> _assignVisit(
      AssignVisit event, Emitter<VisitorDetailsState> emit) async {
    if (await LocalData.hasAreaPlan(localStorageRepo: _localStorageRepo)) {
      _iFlutterNavigator
          .push(AddNewPlanScreen.route(visitorId: event.visitorId));
    } else {
      _iFlutterNavigator
          .push(AddNewVisitScreen.route(visitorId: event.visitorId));
    }
  }
}
