import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/domain/entities/visitors.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan/view/add_new_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_details/view/visitor_details_screen.dart';

part 'visitor_list_event.dart';
part 'visitor_list_state.dart';

class VisitorListBloc extends Bloc<VisitorListEvent, VisitorListState> {
  VisitorListBloc(
      this._apiRepo, this._localStorageRepo, this._iFlutterNavigator)
      : super(VisitorListInitial()) {
    on<GetVisitors>(_getVisitors);
    on<GoToDetails>(_goToDetails);
    on<GoToDashboard>(_goToDashboard);
    on<AssignVisit>(_assignVisit);

    add(GetVisitors());
  }

  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _getVisitors(
      GetVisitors event, Emitter<VisitorListState> emit) async {
    emit(state.copyWith(pageLoader: true));
    final readStorage = await _localStorageRepo.readModel(
        key: visitorListDB, model: const Visitors());

    if (readStorage != null) {
      emit(state.copyWith(visitors: readStorage));
    }

    final visitors = await _apiRepo.post(
        endpoint: usersGetVisitorsEndpoint, responseModel: const Visitors());

    if (visitors != null) {
      emit(state.copyWith(visitors: visitors));
      _localStorageRepo.writeModel(key: visitorListDB, value: visitors);
    }
    emit(state.copyWith(pageLoader: false));
  }

  FutureOr<void> _goToDetails(
      GoToDetails event, Emitter<VisitorListState> emit) {
    _iFlutterNavigator.push(VisitorDetailsScreen.route(visitor: event.visitor));
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<VisitorListState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  Future<FutureOr<void>> _assignVisit(
      AssignVisit event, Emitter<VisitorListState> emit) async {
    if (await LocalData.hasAreaPlan(localStorageRepo: _localStorageRepo)) {
      _iFlutterNavigator
          .push(AddNewPlanScreen.route(visitorId: event.visitorId));
    } else {
      _iFlutterNavigator
          .push(AddNewVisitScreen.route(visitorId: event.visitorId));
    }
  }
}
