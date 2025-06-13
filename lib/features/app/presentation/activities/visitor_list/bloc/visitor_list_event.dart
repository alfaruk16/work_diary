part of 'visitor_list_bloc.dart';

abstract class VisitorListEvent extends Equatable {
  const VisitorListEvent();

  @override
  List<Object> get props => [];
}

class GetVisitors extends VisitorListEvent {}

class GoToDetails extends VisitorListEvent {
  const GoToDetails({required this.visitor});
  final Visitor visitor;
}

class GoToDashboard extends VisitorListEvent {}

class AssignVisit extends VisitorListEvent {
  const AssignVisit({required this.visitorId});
  final int visitorId;
}
