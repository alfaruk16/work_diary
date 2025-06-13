part of 'visit_cancelled_bloc.dart';

abstract class VisitCancelledEvent extends Equatable {
  const VisitCancelledEvent();

  @override
  List<Object> get props => [];
}

class VisiDetailsById extends VisitCancelledEvent {
  const VisiDetailsById({required this.visitData});
  final VisitData visitData;
}

class GotoPlanList extends VisitCancelledEvent {}

class GoToTodayVisit extends VisitCancelledEvent {}

class GoToCreateNewVisit extends VisitCancelledEvent {}

class GoToDashboard extends VisitCancelledEvent {}
