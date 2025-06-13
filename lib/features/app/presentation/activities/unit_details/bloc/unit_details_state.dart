part of 'unit_details_bloc.dart';

class UnitDetailsState extends Equatable {
  const UnitDetailsState({
    this.unitDetail = const UnitDetails(),
  });

  final UnitDetails unitDetail;

  UnitDetailsState copyWith({UnitDetails? unitDetail}) {
    return UnitDetailsState(unitDetail: unitDetail ?? this.unitDetail);
  }

  @override
  List<Object> get props => [unitDetail];
}

class UnitDetailsInitial extends UnitDetailsState {}
