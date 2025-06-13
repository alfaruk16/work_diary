part of 'postpone_bloc.dart';

abstract class PostponeEvent extends Equatable {
  const PostponeEvent();

  @override
  List<Object> get props => [];
}

class GoToTodaysVisitPlanScreen extends PostponeEvent{}