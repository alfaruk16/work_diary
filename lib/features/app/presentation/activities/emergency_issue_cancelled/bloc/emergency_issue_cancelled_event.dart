part of 'emergency_issue_cancelled_bloc.dart';

abstract class EmergencyIssueCancelledEvent extends Equatable {
  const EmergencyIssueCancelledEvent();

  @override
  List<Object> get props => [];
}

class GetEmergencyIssueId extends EmergencyIssueCancelledEvent {
  const GetEmergencyIssueId({required this.visitData});
  final VisitData visitData;
}

class GotToIssueList extends EmergencyIssueCancelledEvent {}

class MenuItemScreens extends EmergencyIssueCancelledEvent {
  const MenuItemScreens({required this.name});
  final String name;
}
