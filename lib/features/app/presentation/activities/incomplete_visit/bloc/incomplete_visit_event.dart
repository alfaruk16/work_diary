part of 'incomplete_visit_bloc.dart';

abstract class IncompleteVisitEvent extends Equatable {
  const IncompleteVisitEvent();

  @override
  List<Object> get props => [];
}

class GetVisitDetails extends IncompleteVisitEvent {
  const GetVisitDetails({required this.visitData});
  final VisitData visitData;
}
