part of 'add_new_visit_bloc.dart';

abstract class AddNewVisitEvent extends Equatable {
  const AddNewVisitEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyIdEvent extends AddNewVisitEvent {
  const GetCompanyIdEvent({this.visitorId});
  final int? visitorId;
}

class GetVisitObjectiveEvent extends AddNewVisitEvent {}

class GetZoneEvent extends AddNewVisitEvent {}

class GetUnits extends AddNewVisitEvent {
  const GetUnits({this.zoneId});
  final int? zoneId;
}

class SelectDate extends AddNewVisitEvent {
  const SelectDate({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetObjEvent extends AddNewVisitEvent {
  const GetObjEvent({required this.objectives});
  final List<String> objectives;
}

class GetZoneIndexEvent extends AddNewVisitEvent {
  const GetZoneIndexEvent({required this.zoneIndex});
  final int zoneIndex;
}

class UnitSelected extends AddNewVisitEvent {
  const UnitSelected({required this.unitIndex});
  final int unitIndex;
}

class UnitTypeSelected extends AddNewVisitEvent {
  const UnitTypeSelected({required this.unitIndex});
  final int unitIndex;
}

class VisitorSelected extends AddNewVisitEvent {
  const VisitorSelected({required this.visitorId});
  final int visitorId;
}

class VisitNoteChangedEvent extends AddNewVisitEvent {
  const VisitNoteChangedEvent({required this.visitNote});
  final String visitNote;
}

class GetVisitorsEvent extends AddNewVisitEvent {}

class CreateVisitEvent extends AddNewVisitEvent {}

class MenuItemScreens extends AddNewVisitEvent {
  const MenuItemScreens({required this.name});
  final String name;
}