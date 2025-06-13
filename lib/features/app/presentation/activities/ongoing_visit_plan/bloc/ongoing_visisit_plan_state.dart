part of 'ongoing_visisit_plan_bloc.dart';

class OngoingVisitPlanState extends Equatable {
  const OngoingVisitPlanState({
    this.visitId = -1,
    this.visit = const CompleteVisitResponse(),
    this.loading = false,
  });

  final int visitId;
  final CompleteVisitResponse visit;
  final bool loading;

  OngoingVisitPlanState copyWith(
      {int? visitId, CompleteVisitResponse? visit, bool? loading}) {
    return OngoingVisitPlanState(
        visitId: visitId ?? this.visitId,
        visit: visit ?? this.visit,
        loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [visitId, visit, loading];
}

class OngoingVisitPlanInitial extends OngoingVisitPlanState {}
