part of 'emergency_issue_bloc.dart';

abstract class EmergencyIssueEvent extends Equatable {
  const EmergencyIssueEvent();

  @override
  List<Object> get props => [];
}

class GoToPlanList extends EmergencyIssueEvent {
  const GoToPlanList({required this.planType, required this.visitData});
  final String planType;
  final VisitData visitData;
}

class DateChanged extends EmergencyIssueEvent {
  const DateChanged({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetTodaysVisitPlan extends EmergencyIssueEvent {}

class GetVisitStatus extends EmergencyIssueEvent {}

class SelectedVisitStatus extends EmergencyIssueEvent {
  const SelectedVisitStatus({required this.selectedIndex});
  final int selectedIndex;
}

class SelectedVisitDate extends EmergencyIssueEvent {
  const SelectedVisitDate({required this.selectedIndex});
  final int selectedIndex;
}

class UpdateVisiteDate extends EmergencyIssueEvent {
  const UpdateVisiteDate(
      {required this.updateDate, required this.selectedDate});
  final String updateDate;
  final int selectedDate;
}

class PageIncrement extends EmergencyIssueEvent {}

class CreateEmergencyIssue extends EmergencyIssueEvent {
  const CreateEmergencyIssue({required this.context});
  final BuildContext context;
}

class MenuItemScreens extends EmergencyIssueEvent {
  const MenuItemScreens({required this.name, required this.context});
  final String name;
  final BuildContext context;
}

class GetComments extends EmergencyIssueEvent {
  const GetComments({required this.id, required this.status});
  final int id;
  final String status;
}

class UpdateStatus extends EmergencyIssueEvent {
  const UpdateStatus({
    required this.id,
    required this.status,
    required this.comments,
  });
  final int id;
  final String status, comments;
}

class IsSupervisor extends EmergencyIssueEvent {}

class TabChanged extends EmergencyIssueEvent {
  const TabChanged({required this.selectedTab, required this.context});
  final int selectedTab;
  final BuildContext context;
}

class Reload extends EmergencyIssueEvent {}

class CheckLocal extends EmergencyIssueEvent {}

class UpdateLoader extends EmergencyIssueEvent {
  const UpdateLoader({required this.loading});
  final bool loading;
}
