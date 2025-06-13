part of 'emergency_issue_bloc.dart';

class EmergencyIssueState extends Equatable {
  const EmergencyIssueState(
      {this.listForDates = "Emergency Issues",
      this.isLoading = false,
      this.isSupervisor = true,
      this.selectedTab = 0});

  final String listForDates;
  final bool isLoading, isSupervisor;
  final int selectedTab;

  EmergencyIssueState copyWith(
      {String? listForDates,
      bool? isLoading,
      bool? isSupervisor,
      int? selectedTab}) {
    return EmergencyIssueState(
        listForDates: listForDates ?? this.listForDates,
        isLoading: isLoading ?? this.isLoading,
        isSupervisor: isSupervisor ?? this.isSupervisor,
        selectedTab: selectedTab ?? this.selectedTab);
  }

  @override
  List<Object> get props =>
      [listForDates, isLoading, isSupervisor, selectedTab];
}

class EmergencyIssueInitial extends EmergencyIssueState {}
