import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/check_in/view/check_in_screen.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc(this._iFlutterNavigator) : super(CheckOutInitial()) {
    on<GoToCheckInEvent>(_goToCheckIn);
  }

  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _goToCheckIn(GoToCheckInEvent event, Emitter<CheckOutState> emit) {
    _iFlutterNavigator.push(CheckInScreen.route());
  }
}
