part of 'unit_details_bloc.dart';

abstract class UnitDetailsEvent extends Equatable {
  const UnitDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyUnitDetails extends UnitDetailsEvent {
  const GetCompanyUnitDetails({required this.unitData});
  final UnitData unitData;
}

class GoToDashboard extends UnitDetailsEvent {}

class GoToAddNewUnit extends UnitDetailsEvent {}
