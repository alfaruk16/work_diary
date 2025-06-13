part of 'order_note_bloc.dart';

abstract class OrderNoteState extends Equatable {
  OrderNoteState();

  final filterController = TextEditingController();
  final filterFocusNode = FocusNode();

  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  
  @override
  List<Object> get props => [];
}

class OrderNoteInitial extends OrderNoteState {}
