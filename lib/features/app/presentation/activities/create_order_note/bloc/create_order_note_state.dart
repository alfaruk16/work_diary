part of 'create_order_note_bloc.dart';

abstract class CreateOrderNoteState extends Equatable {
  CreateOrderNoteState();

  final qtyController = TextEditingController();
  final qtyFocusNode = FocusNode();

  final noteController = TextEditingController();
  final noteFocusNode = FocusNode();


  @override
  List<Object> get props => [];
}

class CreateOrderNoteInitial extends CreateOrderNoteState {}
