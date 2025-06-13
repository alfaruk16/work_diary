part of 'order_note_bloc.dart';

abstract class OrderNoteEvent extends Equatable {
  const OrderNoteEvent();

  @override
  List<Object> get props => [];
}

class GoToCreateOrderNoteScreen extends OrderNoteEvent {}

class GoToOrderNotePlanList extends OrderNoteEvent {
  const GoToOrderNotePlanList(this.planType);

  final String planType;

  @override
  List<Object> get props => [];
}
