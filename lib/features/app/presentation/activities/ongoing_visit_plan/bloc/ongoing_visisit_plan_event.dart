part of 'ongoing_visisit_plan_bloc.dart';

abstract class OngoingVisitPlanEvent extends Equatable {
  const OngoingVisitPlanEvent();

  @override
  List<Object> get props => [];
}

class OnGoingVisitById extends OngoingVisitPlanEvent {
  const OnGoingVisitById({required this.visitData});
  final VisitData visitData;
}

//old code
class GoToCompletedVisitPlanScreen extends OngoingVisitPlanEvent {}

class GoToAddStockCheckScreen extends OngoingVisitPlanEvent {}

class GoToCompetitorsActivityScreen extends OngoingVisitPlanEvent {}

class GoToMerchandisingScreen extends OngoingVisitPlanEvent {}

class GoToAddFacingScreen extends OngoingVisitPlanEvent {}

class GoToEmergencyIssue extends OngoingVisitPlanEvent {}

class GoToForm extends OngoingVisitPlanEvent {
  const GoToForm({required this.formItem, required this.visitData});
  final FormList formItem;
  final VisitData visitData;
}

class CheckVisitForms extends OngoingVisitPlanEvent {
  const CheckVisitForms({required this.visitId});
  final int visitId;
}

class ShowModal extends OngoingVisitPlanEvent {
  const ShowModal({
    required this.visitId,
    required this.visitConfirmationResponse,
  });
  final int visitId;
  final VisitConfirmationResponse visitConfirmationResponse;
}

class CompleteVisit extends OngoingVisitPlanEvent {
  const CompleteVisit({required this.visitId});
  final int visitId;
}

class GoToTodaysVisit extends OngoingVisitPlanEvent {}

class VisitFormDeleteEvent extends OngoingVisitPlanEvent {
  const VisitFormDeleteEvent({
    required this.id,
    required this.formId,
    required this.visitId,
  });

  final int id, formId, visitId;
}

class GoToCreateNewVisitPlan extends OngoingVisitPlanEvent {}

class GoToDashboard extends OngoingVisitPlanEvent {}

class AddData extends OngoingVisitPlanEvent {
  const AddData({required this.visitData});
  final VisitData visitData;
}

class EditSlot extends OngoingVisitPlanEvent {}

class CompleteSlot extends OngoingVisitPlanEvent {}

class EditForm extends OngoingVisitPlanEvent {
  const EditForm(
      {required this.formItem,
      required this.visitData,
      required this.visitFormId});
  final FormList formItem;
  final VisitData visitData;
  final int visitFormId;
}
