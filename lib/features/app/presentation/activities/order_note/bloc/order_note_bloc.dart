import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/create_order_note/view/create_order_note_screen.dart';

import '../../order_cancel/view/order_cancel_screen.dart';
import '../../order_completed/view/order_completed_screen.dart';
import '../../order_note_details/view/order_note_details_screen.dart';

part 'order_note_event.dart';
part 'order_note_state.dart';

class OrderNoteBloc extends Bloc<OrderNoteEvent, OrderNoteState> {
  OrderNoteBloc(this._iFlutterNavigator) : super(OrderNoteInitial()) {
    on<GoToCreateOrderNoteScreen>(_goToCreaterOderNote);
    on<GoToOrderNotePlanList>(_goToOrderNotePlanList);
  }

  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _goToCreaterOderNote(
      GoToCreateOrderNoteScreen event, Emitter<OrderNoteState> emit) {
    _iFlutterNavigator.push(CreateOrderNoteScreen.route());
  }

  FutureOr<void> _goToOrderNotePlanList(
      GoToOrderNotePlanList event, Emitter<OrderNoteState> emit) {
    if (event.planType == "Pending") {
      _iFlutterNavigator.push(OrderNoteDetailsScreen.route());
    } else if (event.planType == "Complete") {
      _iFlutterNavigator.push(OrderCompletedScreen.route());
    } else if (event.planType == "Cancel") {
      _iFlutterNavigator.push(OrderCancelScreen.route());
    }
  }
}
