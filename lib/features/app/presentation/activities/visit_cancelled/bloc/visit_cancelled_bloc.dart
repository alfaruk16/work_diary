import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/view/add_new_plan_visit_screen.dart';

part 'visit_cancelled_event.dart';
part 'visit_cancelled_state.dart';

class VisitCancelledBloc
    extends Bloc<VisitCancelledEvent, VisitCancelledState> {
  VisitCancelledBloc(this._iFlutterNavigator, this._apiRepo)
      : super(VisitCancelledInitial()) {
    on<VisiDetailsById>(_visitDetailsById);
    on<GotoPlanList>(_gotoPlanList);
    on<GoToTodayVisit>(_goToTodayVisit);
    on<GoToCreateNewVisit>(_goToCreateNewVisit);
    on<GoToDashboard>(_goToDashboard);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;

  FutureOr<void> _visitDetailsById(
      VisiDetailsById event, Emitter<VisitCancelledState> emit) async {
    emit(state.copyWith(
        visit: CompleteVisitResponse(visitData: event.visitData),
        loading: true));
    final waitingVisitResponse = await _apiRepo.post(
      endpoint: visitsShowEndpoint,
      body: VisitId(id: state.visit.visitData!.id!),
      responseModel: const CompleteVisitResponse(),
    );
    emit(state.copyWith(loading: false));
    if (waitingVisitResponse != null) {
      emit(state.copyWith(visit: waitingVisitResponse));
    }
  }

  FutureOr<void> _gotoPlanList(
      GotoPlanList event, Emitter<VisitCancelledState> emit) {
    _iFlutterNavigator.pop();
  }

  FutureOr<void> _goToTodayVisit(
      GoToTodayVisit event, Emitter<VisitCancelledState> emit) {
    _iFlutterNavigator.pop();
  }

  Future<FutureOr<void>> _goToCreateNewVisit(
      GoToCreateNewVisit event, Emitter<VisitCancelledState> emit) async {
    if (await LocalData.hasAreaPlan(
        localStorageRepo: getIt<LocalStorageRepo>())) {
      _iFlutterNavigator.push(AddNewPlanVisitScreen.route());
    } else {
      _iFlutterNavigator.push(AddNewVisitScreen.route());
    }
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<VisitCancelledState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }
}
