part of 'complete_emergency_issue_details_bloc.dart';

abstract class CompleteEmergencyIssueDetailsEvent extends Equatable {
  const CompleteEmergencyIssueDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetIssueId extends CompleteEmergencyIssueDetailsEvent {
  const GetIssueId({required this.visitData});
  final VisitData visitData;
}

class GoToEmergencyIssueScreen extends CompleteEmergencyIssueDetailsEvent {}
