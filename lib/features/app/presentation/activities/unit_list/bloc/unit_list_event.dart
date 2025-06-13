part of 'unit_list_bloc.dart';

abstract class UnitListEvent extends Equatable {
  const UnitListEvent();

  @override
  List<Object> get props => [];
}

class GetUnit extends UnitListEvent {}

class GoToUnitDetails extends UnitListEvent {
  const GoToUnitDetails({required this.unitData});
  final UnitData unitData;
}

class GoToAddNewUnit extends UnitListEvent {}

class MenuItemScreens extends UnitListEvent {
  const MenuItemScreens({required this.name});
  final String name;
}

class PageIncrement extends UnitListEvent {}
