import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/plan_details.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan/view/add_new_plan_screen.dart';

part 'plan_cancelled_event.dart';
part 'plan_cancelled_state.dart';

class PlanCancelledBloc extends Bloc<PlanCancelledEvent, PlanCancelledState> {
  PlanCancelledBloc(this._iFlutterNavigator, this._apiRepo)
      : super(VisitCancelledInitial()) {
    on<VisiDetailsById>(_visitDetailsById);
    on<GotoPlanList>(_gotoPlanList);
    on<GoToTodayPlan>(_goToTodayPlan);
    on<GoToCreateNewPlan>(_goToCreateNewPlan);
    on<GoToDashboard>(_goToDashboard);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;

  FutureOr<void> _visitDetailsById(
      VisiDetailsById event, Emitter<PlanCancelledState> emit) async {
    emit(state.copyWith(
        visit: PlanDetailsResponse(visitData: event.visitData), loading: true));
    final waitingVisitResponse = await _apiRepo.post(
      endpoint: getPlanDetailsEndpoint,
      body: VisitId(id: state.visit.visitData!.id!),
      responseModel: const PlanDetailsResponse(),
    );
    emit(state.copyWith(loading: false));
    if (waitingVisitResponse != null) {
      emit(state.copyWith(visit: waitingVisitResponse));
    }
  }

  FutureOr<void> _gotoPlanList(
      GotoPlanList event, Emitter<PlanCancelledState> emit) {
    _iFlutterNavigator.pop();
  }
  FutureOr<void> _goToTodayPlan(
      GoToTodayPlan event, Emitter<PlanCancelledState> emit) {
    _iFlutterNavigator.pop();
  }

  FutureOr<void> _goToCreateNewPlan(
      GoToCreateNewPlan event, Emitter<PlanCancelledState> emit) {
    _iFlutterNavigator.push(AddNewPlanScreen.route());
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<PlanCancelledState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }
}
