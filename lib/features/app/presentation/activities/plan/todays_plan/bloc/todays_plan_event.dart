part of 'todays_plan_bloc.dart';

abstract class TodaysPlanEvent extends Equatable {
  const TodaysPlanEvent();

  @override
  List<Object> get props => [];
}

class GoToPlanList extends TodaysPlanEvent {
  const GoToPlanList({required this.planType, required this.visitData});
  final String planType;
  final VisitData visitData;
}

class DateChanged extends TodaysPlanEvent {
  const DateChanged({required this.date, required this.dateController});
  final String date;
  final TextEditingController dateController;
}

class GetTodaysPlan extends TodaysPlanEvent {}

class GetVisitStatus extends TodaysPlanEvent {}

class SelectedVisitStatus extends TodaysPlanEvent {
  const SelectedVisitStatus({required this.selectedIndex});
  final int selectedIndex;
}

class SelectedVisitDate extends TodaysPlanEvent {
  const SelectedVisitDate(
      {this.selectedIndex, this.selectedTab, this.selectedVisitStatus});
  final int? selectedIndex;
  final int? selectedTab;
  final String? selectedVisitStatus;
}

class UpdateVisitDate extends TodaysPlanEvent {
  const UpdateVisitDate({required this.updateDate, required this.selectedDate});
  final String updateDate;
  final int selectedDate;
}

class GetComments extends TodaysPlanEvent {
  const GetComments({required this.id, required this.status});
  final int id;
  final String status;
}

class UpdateStatus extends TodaysPlanEvent {
  const UpdateStatus({
    required this.id,
    required this.status,
    required this.comments,
  });
  final int id;
  final String status, comments;
}

class PageIncrement extends TodaysPlanEvent {}

class PageIncrementSupervisor extends TodaysPlanEvent {}

class IsSupervisor extends TodaysPlanEvent {}

class GoToCreateNewPlan extends TodaysPlanEvent {
  const GoToCreateNewPlan({required this.context});
  final BuildContext context;
}

class GoToDashboard extends TodaysPlanEvent {}

class SetPlanType extends TodaysPlanEvent {
  const SetPlanType(
      {this.planListType,
      this.selectedTab,
      this.selectedDateDropdown,
      this.status});

  final PlanListType? planListType;
  final int? selectedTab;
  final int? selectedDateDropdown;
  final String? status;
}

class MenuItemScreens extends TodaysPlanEvent {
  const MenuItemScreens({required this.name, required this.context});
  final String name;
  final BuildContext context;
}

class TabChanged extends TodaysPlanEvent {
  const TabChanged({required this.index, required this.context});
  final int index;
  final BuildContext context;
}

class UpdateVisitItem extends TodaysPlanEvent {
  const UpdateVisitItem({required this.updateVisit});
  final VisitData updateVisit;
}

class CheckLocal extends TodaysPlanEvent {
  const CheckLocal({required this.selectedDateDropdown});
  final int selectedDateDropdown;
}

class ChangeTab extends TodaysPlanEvent {
  const ChangeTab({required this.tabIndex});
  final int tabIndex;
}

class UpdateLoader extends TodaysPlanEvent {
  const UpdateLoader({required this.loading});
  final bool loading;
}
