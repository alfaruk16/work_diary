part of 'ongoing_emergency_issue_bloc.dart';

abstract class OngoingEmergencyIssueEvent extends Equatable {
  const OngoingEmergencyIssueEvent();

  @override
  List<Object> get props => [];
}

class GoToEmergencyIssueScreen extends OngoingEmergencyIssueEvent {}