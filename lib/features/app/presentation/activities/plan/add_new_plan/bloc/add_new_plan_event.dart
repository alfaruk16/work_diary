part of 'add_new_plan_bloc.dart';

abstract class AddNewPlanEvent extends Equatable {
  const AddNewPlanEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyIdEvent extends AddNewPlanEvent {
  const GetCompanyIdEvent({this.visitorId});
  final int? visitorId;
}

class GetZoneEvent extends AddNewPlanEvent {}

class GetArea extends AddNewPlanEvent {
  const GetArea({this.zoneId});
  final int? zoneId;
}

class SelectDate extends AddNewPlanEvent {
  const SelectDate({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetZoneIndexEvent extends AddNewPlanEvent {
  const GetZoneIndexEvent({required this.zoneIndex});
  final int zoneIndex;
}

class AreaSelected extends AddNewPlanEvent {
  const AreaSelected({required this.areaId});
  final int areaId;
}

class VisitorSelected extends AddNewPlanEvent {
  const VisitorSelected({required this.visitorId});
  final int visitorId;
}

class VisitNoteChangedEvent extends AddNewPlanEvent {
  const VisitNoteChangedEvent({required this.visitNote});
  final String visitNote;
}

class GetVisitorsEvent extends AddNewPlanEvent {}

class CreateVisitEvent extends AddNewPlanEvent {}

class MenuItemScreens extends AddNewPlanEvent {
  const MenuItemScreens({required this.name});
  final String name;
}
