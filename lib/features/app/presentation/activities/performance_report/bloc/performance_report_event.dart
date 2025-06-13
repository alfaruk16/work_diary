part of 'performance_report_bloc.dart';

abstract class PerformanceReportEvent extends Equatable {
  const PerformanceReportEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsById extends PerformanceReportEvent {
  const GetDetailsById({required this.visitorInfo});
  final UserDetails visitorInfo;
}

class GetPerformance extends PerformanceReportEvent {}

class GoToVisitorVisitsScreen extends PerformanceReportEvent {
  const GoToVisitorVisitsScreen({required this.userDetails});
  final UserDetails userDetails;
}

class GoToDashboard extends PerformanceReportEvent {}

class SelectedMonth extends PerformanceReportEvent {
  const SelectedMonth({required this.month});
  final int month;
}
