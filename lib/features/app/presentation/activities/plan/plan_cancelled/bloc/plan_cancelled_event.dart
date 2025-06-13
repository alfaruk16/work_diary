part of 'plan_cancelled_bloc.dart';

abstract class PlanCancelledEvent extends Equatable {
  const PlanCancelledEvent();

  @override
  List<Object> get props => [];
}

class VisiDetailsById extends PlanCancelledEvent {
  const VisiDetailsById({required this.visitData});
  final VisitData visitData;
}

class GotoPlanList extends PlanCancelledEvent {}

class GoToTodayPlan extends PlanCancelledEvent {}

class GoToCreateNewPlan extends PlanCancelledEvent {}

class GoToDashboard extends PlanCancelledEvent {}
