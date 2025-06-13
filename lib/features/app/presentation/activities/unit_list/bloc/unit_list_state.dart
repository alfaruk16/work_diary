part of 'unit_list_bloc.dart';

class UnitListState extends Equatable {
  const UnitListState(
      {this.units = const UnitResponse(),
      this.incrementLoader = false,
      this.currentPage = 1});

  final UnitResponse units;
  final bool incrementLoader;
  final int currentPage;

  UnitListState copyWith(
      {UnitResponse? units, bool? incrementLoader, int? currentPage}) {
    return UnitListState(
        units: units ?? this.units,
        incrementLoader: incrementLoader ?? this.incrementLoader,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object> get props => [units, incrementLoader, currentPage];
}

class AddUnitZoneInitial extends UnitListState {}
