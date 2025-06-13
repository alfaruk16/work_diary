part of 'emergency_issue_details_bloc.dart';

abstract class EmergencyIssueDetailsEvent extends Equatable {
  const EmergencyIssueDetailsEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends EmergencyIssueDetailsEvent {}

class GetEmergencyIssueId extends EmergencyIssueDetailsEvent {
  const GetEmergencyIssueId({required this.visitData});
  final VisitData visitData;
}

class GetComments extends EmergencyIssueDetailsEvent {
  const GetComments({required this.comments});
  final String comments;
}

class CompleteEmergencyIssue extends EmergencyIssueDetailsEvent {}

class GotToIssueList extends EmergencyIssueDetailsEvent {}

class MenuItemScreens extends EmergencyIssueDetailsEvent {
  const MenuItemScreens({required this.name});
  final String name;
}
