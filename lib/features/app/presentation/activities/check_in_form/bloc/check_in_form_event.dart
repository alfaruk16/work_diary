part of 'check_in_form_bloc.dart';

abstract class CheckInFormEvent extends Equatable {
  const CheckInFormEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends CheckInFormEvent {}

class GetId extends CheckInFormEvent {
  const GetId({required this.visitData});
  final VisitData visitData;
}

class SaveWithAttendance extends CheckInFormEvent {}

class GoToTodayVisitPlan extends CheckInFormEvent {}

class GoToCreateNewVisitPlan extends CheckInFormEvent {}

class GoToDashboard extends CheckInFormEvent {}

class CancelAnImage extends CheckInFormEvent {
  const CancelAnImage({required this.index});
  final int index;
}
