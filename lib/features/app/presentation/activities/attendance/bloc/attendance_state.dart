part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  AttendanceState();

  final filterController = TextEditingController();
  final filterFocusNode = FocusNode();

  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  
  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}
