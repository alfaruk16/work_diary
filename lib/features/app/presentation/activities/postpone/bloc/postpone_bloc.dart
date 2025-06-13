import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/view/todays_visit_screen.dart';

part 'postpone_event.dart';
part 'postpone_state.dart';

class PostponeBloc extends Bloc<PostponeEvent, PostponeState> {
  PostponeBloc(this._iFlutterNavigator) : super(PostponeInitial()) {
    on<GoToTodaysVisitPlanScreen>(_goToTodayVisitPlan);
  }
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _goToTodayVisitPlan(GoToTodaysVisitPlanScreen event, Emitter<PostponeState> emit) {
    _iFlutterNavigator.push(TodaysVisitScreen.route());
  }
}
