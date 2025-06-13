import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/view/emergency_issue_screen.dart';

part 'ongoing_emergency_issue_event.dart';
part 'ongoing_emergency_issue_state.dart';

class OngoingEmergencyIssueBloc extends Bloc<OngoingEmergencyIssueEvent, OngoingEmergencyIssueState> {
  OngoingEmergencyIssueBloc(this._iFlutterNavigator) : super(OngoingEmergencyIssueInitial()) {
    on<GoToEmergencyIssueScreen>(_goToEmergencyIssue);
  }

  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _goToEmergencyIssue(GoToEmergencyIssueScreen event, Emitter<OngoingEmergencyIssueState> emit) {
    _iFlutterNavigator.push(EmergencyIssueScreen.route());
  }
}
