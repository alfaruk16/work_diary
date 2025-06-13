part of 'visit_details_bloc.dart';

abstract class VisitDetailsEvent extends Equatable {
  const VisitDetailsEvent();

  @override
  List<Object> get props => [];
}

class TimeChange extends VisitDetailsEvent {}

class UpdateTime extends VisitDetailsEvent {}

class GoToEmergency extends VisitDetailsEvent {}

class GetVisitId extends VisitDetailsEvent {
  const GetVisitId({required this.visitData});
  final VisitData visitData;
}

class StartCheckIn extends VisitDetailsEvent {
  const StartCheckIn({required this.unitName, required this.unitCode});
  final String unitName;
  final String unitCode;
}

class ShowVisitModal extends VisitDetailsEvent {
  const ShowVisitModal({required this.unitName, required this.unitCode});
  final String unitName;
  final String unitCode;
}

class GetEmergencyVisit extends VisitDetailsEvent {}

class EmergencyIssueDetails extends VisitDetailsEvent {
  const EmergencyIssueDetails({required this.visitData});
  final VisitData visitData;
}

class GetComments extends VisitDetailsEvent {
  const GetComments({required this.id, required this.status});
  final int id;
  final String status;
}

class UpdateStatus extends VisitDetailsEvent {
  const UpdateStatus({
    required this.id,
    required this.status,
    required this.commnents,
  });
  final int id;
  final String status, commnents;
}
class GoToTodayVisitPlan extends VisitDetailsEvent {}

class GoToCreateNewVisitPlan extends VisitDetailsEvent {}

class GoToDashboard extends VisitDetailsEvent {}

class EditSlot extends VisitDetailsEvent {}

class CompleteSlot extends VisitDetailsEvent {}
