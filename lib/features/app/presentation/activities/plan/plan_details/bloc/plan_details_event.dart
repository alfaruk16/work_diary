part of 'plan_details_bloc.dart';

abstract class PlanDetailsEvent extends Equatable {
  const PlanDetailsEvent();

  @override
  List<Object> get props => [];
}

class TimeChange extends PlanDetailsEvent {}

class UpdateTime extends PlanDetailsEvent {}

class GoToEmergency extends PlanDetailsEvent {}

class GetVisitId extends PlanDetailsEvent {
  const GetVisitId({required this.visitData});
  final VisitData visitData;
}

class StartCheckIn extends PlanDetailsEvent {
  const StartCheckIn({required this.unitName, required this.unitCode});
  final String unitName;
  final String unitCode;
}

class ShowVisitModal extends PlanDetailsEvent {
  const ShowVisitModal({required this.unitName, required this.unitCode});
  final String unitName;
  final String unitCode;
}

class GetEmergencyVisit extends PlanDetailsEvent {}

class EmergencyIssueDetails extends PlanDetailsEvent {
  const EmergencyIssueDetails({required this.visitData});
  final VisitData visitData;
}

class GetComments extends PlanDetailsEvent {
  const GetComments(
      {required this.id, required this.status, required this.isCancel});
  final int id;
  final String status;
  final bool isCancel;
}

class UpdateStatus extends PlanDetailsEvent {
  const UpdateStatus(
      {required this.id,
      required this.status,
      required this.comments,
      required this.isCancel});
  final int id;
  final String status, comments;
  final bool isCancel;
}

class GoToTodayPlan extends PlanDetailsEvent {}

class GoToCreateNewPlan extends PlanDetailsEvent {}

class GoToDashboard extends PlanDetailsEvent {}

class EditSlot extends PlanDetailsEvent {}

class CompleteSlot extends PlanDetailsEvent {}

class GoToCreateNewVisitPlan extends PlanDetailsEvent {}
