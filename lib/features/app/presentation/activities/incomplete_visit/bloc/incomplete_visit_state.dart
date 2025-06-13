part of 'incomplete_visit_bloc.dart';

class IncompleteVisitState extends Equatable {
  const IncompleteVisitState({
    this.visit = const CompleteVisitResponse(),
  });

  final CompleteVisitResponse visit;

  IncompleteVisitState copyWith({
    CompleteVisitResponse? visit,
  }) {
    return IncompleteVisitState(
      visit: visit ?? this.visit,
    );
  }

  @override
  List<Object> get props => [visit];
}

class CompletedVisitPlanInitial extends IncompleteVisitState {}
