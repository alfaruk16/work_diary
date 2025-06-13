part of 'todays_visit_bloc.dart';

abstract class TodaysVisitEvent extends Equatable {
  const TodaysVisitEvent();

  @override
  List<Object> get props => [];
}

class GoToPlanList extends TodaysVisitEvent {
  const GoToPlanList({required this.planType, required this.visitData});
  final String planType;
  final VisitData visitData;
}

class DateChanged extends TodaysVisitEvent {
  const DateChanged({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetTodaysVisitPlan extends TodaysVisitEvent {}

class GetVisitStatus extends TodaysVisitEvent {}

class SelectedVisitStatus extends TodaysVisitEvent {
  const SelectedVisitStatus({required this.selectedIndex});
  final int selectedIndex;
}

class SelectedVisitDate extends TodaysVisitEvent {
  const SelectedVisitDate(
      {this.selectedIndex, this.selectedTab, this.selectedVisitStatus});
  final int? selectedIndex;
  final int? selectedTab;
  final String? selectedVisitStatus;
}

class UpdateVisitDate extends TodaysVisitEvent {
  const UpdateVisitDate({required this.updateDate, required this.selectedDate});
  final String updateDate;
  final int selectedDate;
}

class GetComments extends TodaysVisitEvent {
  const GetComments({required this.id, required this.status});
  final int id;
  final String status;
}

class UpdateStatus extends TodaysVisitEvent {
  const UpdateStatus({
    required this.id,
    required this.status,
    required this.comments,
  });
  final int id;
  final String status, comments;
}

class PageIncrement extends TodaysVisitEvent {}

class PageIncrementSupervisor extends TodaysVisitEvent {}

class IsSupervisor extends TodaysVisitEvent {}

class GoToCreateNewVisitPlan extends TodaysVisitEvent {
  const GoToCreateNewVisitPlan({required this.context});
  final BuildContext context;
}

class GoToDashboard extends TodaysVisitEvent {}

class SetPlanListType extends TodaysVisitEvent {
  const SetPlanListType(
      {this.planListType,
      this.selectedTab,
      this.selectedDateDropdown,
      this.status});

  final PlanListType? planListType;
  final int? selectedTab;
  final int? selectedDateDropdown;
  final String? status;
}

class MenuItemScreens extends TodaysVisitEvent {
  const MenuItemScreens({required this.name, required this.context});
  final String name;
  final BuildContext context;
}

class TabChanged extends TodaysVisitEvent {
  const TabChanged({required this.index, required this.context});
  final int index;
  final BuildContext context;
}

class UpdateVisitItem extends TodaysVisitEvent {
  const UpdateVisitItem({required this.updateVisit});
  final VisitData updateVisit;
}

class CheckLocal extends TodaysVisitEvent {
  const CheckLocal({required this.selectedDateDropdown});
  final int selectedDateDropdown;
}

class ChangeTab extends TodaysVisitEvent {
  const ChangeTab({required this.tabIndex});
  final int tabIndex;
}

class UpdateLoader extends TodaysVisitEvent {
  const UpdateLoader({required this.loading});
  final bool loading;
}
