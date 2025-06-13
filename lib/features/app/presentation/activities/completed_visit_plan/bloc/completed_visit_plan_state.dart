part of 'completed_visit_plan_bloc.dart';

class CompletedVisitPlanState extends Equatable {
  const CompletedVisitPlanState(
      {this.visit = const CompleteVisitResponse(), this.loading = false});

  final CompleteVisitResponse visit;
  final bool loading;

  CompletedVisitPlanState copyWith(
      {CompleteVisitResponse? visit, bool? loading}) {
    return CompletedVisitPlanState(
        visit: visit ?? this.visit, loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [visit, loading];
}

class CompletedVisitPlanInitial extends CompletedVisitPlanState {}
