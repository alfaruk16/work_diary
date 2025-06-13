part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState(
      {this.userDetails = const UserDetails(),
      this.selectedTab = 0,
      this.dashboard = const DashboardResponse(),
      this.dashboardSupervisor = const DashboardResponse(),
      this.loading = false,
      this.chartLoading = false,
      this.isSuperVisor = false,
      this.chartData = const ChartResponse(),
      this.chartDataSuperVisor = const ChartResponse(),
      this.previousToDoList = const Visits(),
      this.toDoList = const ToDoList(),
      this.isContinue = true,
      this.updateTodoLoading = false,
      this.visitors = const Visitors(),
      this.appVersion = '',
      this.hasAreaPlan = false,
      this.isCheckInEnable = false,
      this.isCheckInLoading = false});

  final UserDetails userDetails;
  final int selectedTab;
  final DashboardResponse dashboard;
  final DashboardResponse dashboardSupervisor;
  final bool loading, chartLoading;
  final bool isSuperVisor;
  final ChartResponse chartData;
  final ChartResponse chartDataSuperVisor;
  final Visits previousToDoList;
  final ToDoList toDoList;
  final bool isContinue;
  final bool updateTodoLoading;
  final Visitors visitors;
  final String appVersion;
  final bool hasAreaPlan;
  final bool isCheckInEnable;
  final bool isCheckInLoading;

  DashboardState copyWith(
      {UserDetails? userDetails,
      int? selectedTab,
      DashboardResponse? dashboard,
      DashboardResponse? dashboardSupervisor,
      bool? loading,
      bool? chartLoading,
      bool? isSuperVisor,
      ChartResponse? chartData,
      ChartResponse? chartDataSuperVisor,
      Visits? previousToDoList,
      ToDoList? toDoList,
      bool? isContinue,
      bool? updateTodoLoading,
      Visitors? visitors,
      String? appVersion,
      bool? hasAreaPlan,
      bool? isCheckInEnable,
      bool? isCheckInLoading}) {
    return DashboardState(
        userDetails: userDetails ?? this.userDetails,
        selectedTab: selectedTab ?? this.selectedTab,
        dashboard: dashboard ?? this.dashboard,
        dashboardSupervisor: dashboardSupervisor ?? this.dashboardSupervisor,
        loading: loading ?? this.loading,
        chartLoading: chartLoading ?? this.chartLoading,
        isSuperVisor: isSuperVisor ?? this.isSuperVisor,
        chartData: chartData ?? this.chartData,
        chartDataSuperVisor: chartDataSuperVisor ?? this.chartDataSuperVisor,
        previousToDoList: previousToDoList ?? this.previousToDoList,
        toDoList: toDoList ?? this.toDoList,
        isContinue: isContinue ?? this.isContinue,
        updateTodoLoading: updateTodoLoading ?? this.updateTodoLoading,
        visitors: visitors ?? this.visitors,
        appVersion: appVersion ?? this.appVersion,
        hasAreaPlan: hasAreaPlan ?? this.hasAreaPlan,
        isCheckInEnable: isCheckInEnable ?? this.isCheckInEnable,
        isCheckInLoading: isCheckInLoading ?? this.isCheckInLoading);
  }

  @override
  List<Object> get props => [
        userDetails,
        selectedTab,
        dashboard,
        dashboardSupervisor,
        loading,
        isSuperVisor,
        chartData,
        chartLoading,
        chartDataSuperVisor,
        previousToDoList,
        toDoList,
        isContinue,
        updateTodoLoading,
        visitors,
        appVersion,
        hasAreaPlan,
        isCheckInEnable,
        isCheckInLoading
      ];
}
