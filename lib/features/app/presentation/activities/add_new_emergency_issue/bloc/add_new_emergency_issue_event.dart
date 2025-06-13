part of 'add_new_emergency_issue_bloc.dart';

abstract class AddNewEmergencyIssueEvent extends Equatable {
  const AddNewEmergencyIssueEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyIdEvent extends AddNewEmergencyIssueEvent {}

class GetVisitObjectiveEvent extends AddNewEmergencyIssueEvent {}

class GetZoneEvent extends AddNewEmergencyIssueEvent {}

class GetUnits extends AddNewEmergencyIssueEvent {
  const GetUnits({this.zoneId});
  final int? zoneId;
}

class SelectDate extends AddNewEmergencyIssueEvent {
  const SelectDate({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetObjEvent extends AddNewEmergencyIssueEvent {
  const GetObjEvent({required this.objectives});
  final List<String> objectives;
}

class GetZoneIndexEvent extends AddNewEmergencyIssueEvent {
  const GetZoneIndexEvent({required this.zoneIndex});
  final int zoneIndex;
}

class UnitSelected extends AddNewEmergencyIssueEvent {
  const UnitSelected({required this.unitIndex});
  final int unitIndex;
}

class UnitTypeSelected extends AddNewEmergencyIssueEvent {
  const UnitTypeSelected({required this.unitIndex});
  final int unitIndex;
}

class VisitorSelected extends AddNewEmergencyIssueEvent {
  const VisitorSelected({required this.visitorId});
  final int visitorId;
}

class TaskNote extends AddNewEmergencyIssueEvent {
  const TaskNote({required this.taskNote});
  final String taskNote;
}

class GetVisitorsEvent extends AddNewEmergencyIssueEvent {}

class CreateEmergencyIssue extends AddNewEmergencyIssueEvent {}

class MenuItemScreens extends AddNewEmergencyIssueEvent {
  const MenuItemScreens({required this.name});
  final String name;
}
