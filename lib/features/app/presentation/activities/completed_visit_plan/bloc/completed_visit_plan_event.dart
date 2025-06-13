part of 'completed_visit_plan_bloc.dart';

abstract class CompletedVisitPlanEvent extends Equatable {
  const CompletedVisitPlanEvent();

  @override
  List<Object> get props => [];
}

class GetVisitDetails extends CompletedVisitPlanEvent {
  const GetVisitDetails({required this.visitData});
  final VisitData visitData;
}
