part of 'visitor_details_bloc.dart';

abstract class VisitorDetailsEvent extends Equatable {
  const VisitorDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetDetailsById extends VisitorDetailsEvent {
  const GetDetailsById({required this.visitorInfo});
  final Visitor visitorInfo;
}

class GetChartById extends VisitorDetailsEvent {
  const GetChartById({required this.id});
  final int id;
}

class GoToVisitorVisitsScreen extends VisitorDetailsEvent {
  const GoToVisitorVisitsScreen({required this.userDetails});
  final UserDetails userDetails;
}

class GoToDashboard extends VisitorDetailsEvent {}

class GoToPerformanceReport extends VisitorDetailsEvent {}

class AssignVisit extends VisitorDetailsEvent {
  const AssignVisit({required this.visitorId});
  final int visitorId;
}
