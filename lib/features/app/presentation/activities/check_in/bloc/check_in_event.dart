part of 'check_in_bloc.dart';

abstract class CheckInEvent extends Equatable {
  const CheckInEvent();

  @override
  List<Object> get props => [];
}

class GoToLoginScreen extends CheckInEvent {}

class GoToCheckInFormScreen extends CheckInEvent {}

class GoToVisitPlan extends CheckInEvent{}
