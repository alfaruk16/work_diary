part of 'plan_cancelled_bloc.dart';

class PlanCancelledState extends Equatable {
  const PlanCancelledState(
      {this.visitId = 0,
      this.visit = const PlanDetailsResponse(),
      this.loading = false});

  final int visitId;
  final PlanDetailsResponse visit;
  final bool loading;

  PlanCancelledState copyWith(
      {int? visitId, PlanDetailsResponse? visit, bool? loading}) {
    return PlanCancelledState(
        visitId: visitId ?? this.visitId,
        visit: visit ?? this.visit,
        loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [visitId, visit, loading];
}

class VisitCancelledInitial extends PlanCancelledState {}
