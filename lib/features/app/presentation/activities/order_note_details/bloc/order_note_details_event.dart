part of 'order_note_details_bloc.dart';

abstract class OrderNoteDetailsEvent extends Equatable {
  const OrderNoteDetailsEvent();

  @override
  List<Object> get props => [];
}

class GoToOrderCompletedScreen extends OrderNoteDetailsEvent{}