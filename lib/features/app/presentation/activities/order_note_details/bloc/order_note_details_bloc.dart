import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/order_completed/view/order_completed_screen.dart';

part 'order_note_details_event.dart';
part 'order_note_details_state.dart';

class OrderNoteDetailsBloc extends Bloc<OrderNoteDetailsEvent, OrderNoteDetailsState> {
  OrderNoteDetailsBloc(this._iFlutterNavigator) : super(OrderNoteDetailsInitial()) {
    on<GoToOrderCompletedScreen>(_goToOrderComplete);
  }
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _goToOrderComplete(GoToOrderCompletedScreen event, Emitter<OrderNoteDetailsState> emit) {
    _iFlutterNavigator.push(OrderCompletedScreen.route());
  }
}
