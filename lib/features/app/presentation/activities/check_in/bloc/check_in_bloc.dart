import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/login/view/log_in_screen.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/view/todays_visit_screen.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBlock extends Bloc<CheckInEvent, CheckInState> {
  CheckInBlock(this._navigationService) : super(CheckInInitial()) {
    on<GoToLoginScreen>(_onGoToLoginScreen);
    on<GoToCheckInFormScreen>(_onGoToCheckInForm);
    on<GoToVisitPlan>(_goToVisitPlan);
  }

  final IFlutterNavigator _navigationService;

  FutureOr<void> _onGoToLoginScreen(
      GoToLoginScreen event, Emitter<CheckInState> emit) {
    _navigationService.push(LogInScreen.route());
  }

  FutureOr<void> _onGoToCheckInForm(
      GoToCheckInFormScreen event, Emitter<CheckInState> emit) {
    // _navigationService.push(CheckInFormScreen.route(unitName: event.));
  }

  FutureOr<void> _goToVisitPlan(
      GoToVisitPlan event, Emitter<CheckInState> emit) {
    _navigationService.push(TodaysVisitScreen.route());
  }
}
