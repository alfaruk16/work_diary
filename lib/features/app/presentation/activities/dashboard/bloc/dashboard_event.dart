part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class OpenDrawerEvent extends DashboardEvent {
  const OpenDrawerEvent(this.context);
  final BuildContext context;
}

class CloseDrawerEvent extends DashboardEvent {
  const CloseDrawerEvent(this.context);
  final BuildContext context;
}

class CheckIn extends DashboardEvent {}

class CheckOut extends DashboardEvent {
  const CheckOut({required this.attendance});
  final bool attendance;
}

class CheckProfile extends DashboardEvent {}

class MyProfile extends DashboardEvent {}

class Notifications extends DashboardEvent {}

class OrderNote extends DashboardEvent {}

class Attendance extends DashboardEvent {}

class LogOut extends DashboardEvent {}

class GoToCheckOutScreen extends DashboardEvent {}

class GoToUserProfileScreen extends DashboardEvent {}

class GoToNotificationScreen extends DashboardEvent {}

class GoToAddNewVisitScreen extends DashboardEvent {}

class GoToTodaysVisitScreen extends DashboardEvent {
  const GoToTodaysVisitScreen(
      {this.planListType,
      this.selectedDateDropdown,
      this.selectedStatusDropdown});
  final PlanListType? planListType;
  final int? selectedDateDropdown;
  final String? selectedStatusDropdown;
}

class GoToEmergencyIssueScreen extends DashboardEvent {}

class GoToUnitListScreen extends DashboardEvent {}

class GoToOrderNoteScreen extends DashboardEvent {}

class GoToAttendanceScreen extends DashboardEvent {}

class GoToAddUnitScreen extends DashboardEvent {}

class GoToVisitorListScreen extends DashboardEvent {}

class GoToOnGoingVisitPlanScreen extends DashboardEvent {
  const GoToOnGoingVisitPlanScreen({required this.visitData});
  final VisitData visitData;
}

class GetUserProfileEvent extends DashboardEvent {}

class GetDashboardData extends DashboardEvent {
  const GetDashboardData({required this.selectedTab});
  final int selectedTab;
}

class TabChanged extends DashboardEvent {
  const TabChanged({required this.index});
  final int index;
}

class GetChart extends DashboardEvent {
  const GetChart({required this.selectedTab});
  final int selectedTab;
}

class GetPreviousToDoList extends DashboardEvent {}

class ShowPreviousVisitModal extends DashboardEvent {}

class SelectDate extends DashboardEvent {
  const SelectDate({
    required this.date,
    required this.dateController,
    required this.index,
  });
  final int index;
  final String date;
  final TextEditingController dateController;
}

class SwitchEvent extends DashboardEvent {
  const SwitchEvent({required this.isContinue, required this.index});
  final bool isContinue;
  final int index;
}

class UpdateTodoList extends DashboardEvent {}

class CheckLocal extends DashboardEvent {}

class GoToCreateEmergencyIssue extends DashboardEvent {}

class GetVisitors extends DashboardEvent {}

class GoToVisitorDetails extends DashboardEvent {
  const GoToVisitorDetails({required this.visitor});
  final Visitor visitor;
}

class ReviewApp extends DashboardEvent {}

class GetAppVersion extends DashboardEvent {}

class GoToTodayPlanScreen extends DashboardEvent {
  const GoToTodayPlanScreen(
      {this.planListType,
      this.selectedDateDropdown,
      this.selectedStatusDropdown});
  final PlanListType? planListType;
  final int? selectedDateDropdown;
  final String? selectedStatusDropdown;
}

class GoToAddNewPlanScreen extends DashboardEvent {}

class HasAreaPlan extends DashboardEvent {}

class CheckVisitStatus extends DashboardEvent {}

class AssignToNewVisit extends DashboardEvent {
  const AssignToNewVisit({required this.visitorId});
  final int visitorId;
}

class IsCheckInEnabled extends DashboardEvent {}

class CheckPreviousAttendanceIsTrue extends DashboardEvent {}

class GoToPerformance extends DashboardEvent {}
