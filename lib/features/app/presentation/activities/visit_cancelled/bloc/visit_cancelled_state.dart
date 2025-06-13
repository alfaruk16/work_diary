part of 'visit_cancelled_bloc.dart';

class VisitCancelledState extends Equatable {
  const VisitCancelledState(
      {this.visitId = 0,
      this.visit = const CompleteVisitResponse(),
      this.loading = false});

  final int visitId;
  final CompleteVisitResponse visit;
  final bool loading;

  VisitCancelledState copyWith(
      {int? visitId, CompleteVisitResponse? visit, bool? loading}) {
    return VisitCancelledState(
        visitId: visitId ?? this.visitId,
        visit: visit ?? this.visit,
        loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [visitId, visit, loading];
}

class VisitCancelledInitial extends VisitCancelledState {}
