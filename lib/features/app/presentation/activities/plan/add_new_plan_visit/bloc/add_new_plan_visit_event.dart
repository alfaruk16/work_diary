part of 'add_new_plan_visit_bloc.dart';

abstract class AddNewPlanVisitEvent extends Equatable {
  const AddNewPlanVisitEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyIdEvent extends AddNewPlanVisitEvent {
  const GetCompanyIdEvent({this.planId});
  final int? planId;
}

class GetVisitObjectiveEvent extends AddNewPlanVisitEvent {}

class GetZoneEvent extends AddNewPlanVisitEvent {}

class GetUnits extends AddNewPlanVisitEvent {
  const GetUnits({required this.planId});
  final int planId;
}

class SelectDate extends AddNewPlanVisitEvent {
  const SelectDate({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetObjEvent extends AddNewPlanVisitEvent {
  const GetObjEvent({required this.objectives});
  final List<String> objectives;
}

class GetZoneIndexEvent extends AddNewPlanVisitEvent {
  const GetZoneIndexEvent({required this.zoneIndex});
  final int zoneIndex;
}

class UnitSelected extends AddNewPlanVisitEvent {
  const UnitSelected({required this.unitIndex});
  final int unitIndex;
}

class UnitTypeSelected extends AddNewPlanVisitEvent {
  const UnitTypeSelected({required this.unitIndex});
  final int unitIndex;
}

class VisitorSelected extends AddNewPlanVisitEvent {
  const VisitorSelected({required this.visitorIndex});
  final int visitorIndex;
}

class VisitNoteChangedEvent extends AddNewPlanVisitEvent {
  const VisitNoteChangedEvent({required this.visitNote});
  final String visitNote;
}

class GetVisitorsEvent extends AddNewPlanVisitEvent {}

class CreateVisitEvent extends AddNewPlanVisitEvent {}

class MenuItemScreens extends AddNewPlanVisitEvent {
  const MenuItemScreens({required this.name});
  final String name;
}

class GetPlanList extends AddNewPlanVisitEvent {
  const GetPlanList({this.planId});
  final int? planId;
}

class PlanSelected extends AddNewPlanVisitEvent {
  const PlanSelected({required this.planId});
  final int planId;
}

class GoToCreateNewPlan extends AddNewPlanVisitEvent {}
