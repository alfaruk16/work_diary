part of 'create_order_note_bloc.dart';

abstract class CreateOrderNoteEvent extends Equatable {
  const CreateOrderNoteEvent();

  @override
  List<Object> get props => [];
}

class GoToOrderNoteScreen extends CreateOrderNoteEvent{}
