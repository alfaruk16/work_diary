part of 'visitor_visits_bloc.dart';

abstract class VisitorVisitsEvent extends Equatable {
  const VisitorVisitsEvent();

  @override
  List<Object> get props => [];
}

class IsSupervisor extends VisitorVisitsEvent {}

class GetDataById extends VisitorVisitsEvent {
  const GetDataById({required this.userDetails});
  final UserDetails userDetails;
}

class GetvisitById extends VisitorVisitsEvent {
  const GetvisitById({required this.id});
  final int id;
}

class GoToPlanList extends VisitorVisitsEvent {
  const GoToPlanList({required this.planType, required this.visitData});
  final String planType;
  final VisitData visitData;
}

class GetComments extends VisitorVisitsEvent {
  const GetComments({required this.id, required this.status});
  final int id;
  final String status;
}

class UpdateStatus extends VisitorVisitsEvent {
  const UpdateStatus({
    required this.id,
    required this.status,
    required this.comments,
  });
  final int id;
  final String status, comments;
}

class UpdateVisitItem extends VisitorVisitsEvent {
  const UpdateVisitItem({required this.updateVisit});
  final VisitData updateVisit;
}

class PageIncrement extends VisitorVisitsEvent {}

class GoToDashboard extends VisitorVisitsEvent {}
