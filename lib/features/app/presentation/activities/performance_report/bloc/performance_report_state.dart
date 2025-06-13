part of 'performance_report_bloc.dart';

class PerformanceReportState extends Equatable {
  const PerformanceReportState(
      {this.visitorDetails = const UserDetails(),
      this.performance = const PerformanceReport(),
      this.pageLoader = false,
      this.selectedMonth = 0,
      this.months = const [],
      this.monthList = const []});

  final UserDetails visitorDetails;
  final PerformanceReport performance;
  final bool pageLoader;
  final int selectedMonth;
  final List<DateTime> months;
  final List<DropdownItem> monthList;

  PerformanceReportState copyWith({
    UserDetails? visitorDetails,
    PerformanceReport? performance,
    bool? pageLoader,
    int? selectedMonth,
    List<DateTime>? months,
    List<DropdownItem>? monthList,
  }) {
    return PerformanceReportState(
        visitorDetails: visitorDetails ?? this.visitorDetails,
        performance: performance ?? this.performance,
        pageLoader: pageLoader ?? this.pageLoader,
        selectedMonth: selectedMonth ?? this.selectedMonth,
        months: months ?? this.months,
        monthList: monthList ?? this.monthList);
  }

  @override
  List<Object> get props => [
        visitorDetails,
        performance,
        pageLoader,
        selectedMonth,
        months,
        monthList
      ];
}

class VisitorDetailsInitial extends PerformanceReportState {}
