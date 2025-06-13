import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/presentation/activities/order_note/view/order_note_screen.dart';

part 'create_order_note_event.dart';
part 'create_order_note_state.dart';

class CreateOrderNoteBloc extends Bloc<CreateOrderNoteEvent, CreateOrderNoteState> {
  CreateOrderNoteBloc(this._iFlutterNavigator) : super(CreateOrderNoteInitial()) {
    on<GoToOrderNoteScreen>(_goToOrderNoteScreen);
  }

  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _goToOrderNoteScreen(GoToOrderNoteScreen event, Emitter<CreateOrderNoteState> emit) {
    _iFlutterNavigator.push(OrderNoteScreen.route());
  }
}
