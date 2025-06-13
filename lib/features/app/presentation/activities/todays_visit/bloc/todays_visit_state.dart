part of 'todays_visit_bloc.dart';

class TodaysVisitState extends Equatable {
  const TodaysVisitState(
      {this.planListType = "Today's Visit Plan",
      this.isLoading = false,
      this.isSupervisor = true,
      this.selectedTab = 0});

  final String planListType;
  final bool isLoading, isSupervisor;
  final int selectedTab;

  TodaysVisitState copyWith(
      {String? planListType,
      bool? isLoading,
      bool? isSupervisor,
      int? selectedTab}) {
    return TodaysVisitState(
        planListType: planListType ?? this.planListType,
        isLoading: isLoading ?? this.isLoading,
        isSupervisor: isSupervisor ?? this.isSupervisor,
        selectedTab: selectedTab ?? this.selectedTab);
  }

  @override
  List<Object> get props =>
      [planListType, isLoading, isSupervisor, selectedTab];
}
