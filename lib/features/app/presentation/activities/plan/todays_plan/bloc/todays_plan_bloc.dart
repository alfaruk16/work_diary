import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan/view/add_new_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/today_plan_own_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/today_plan_supervisor_bloc.dart';

part 'todays_plan_event.dart';
part 'todays_plan_state.dart';

class TodaysPlanBloc extends Bloc<TodaysPlanEvent, TodaysPlanState> {
  TodaysPlanBloc(this._iFlutterNavigator, this._localStorageRepo)
      : super(const TodaysPlanState()) {
    on<IsSupervisor>(_isSupervisor);
    on<GoToCreateNewPlan>(_goToCreateNewPlan);
    on<GoToDashboard>(_goToDashboard);
    on<SetPlanType>(_setPlanListType);
    on<TabChanged>(_tabChanged);
    on<MenuItemScreens>(_menuItemScreens);
    on<ChangeTab>(_changeTab);
    on<UpdateLoader>(_updateLoader);

    add(IsSupervisor());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _goToCreateNewPlan(
      GoToCreateNewPlan event, Emitter<TodaysPlanState> emit) {
    _iFlutterNavigator.push(AddNewPlanScreen.route()).then((value) {
      if (value != null) {
        final visitData = value as VisitData;
        if (state.selectedTab != (visitData.forOwn! ? 0 : 1)) {
          add(ChangeTab(tabIndex: visitData.forOwn! ? 0 : 1));
        }
        if (state.selectedTab == 0) {
          final bloc = event.context.read<TodaysPlanBlocOwn>();
          bloc.add(SetPlanType(
              selectedTab: visitData.forOwn! ? 0 : 1,
              selectedDateDropdown: visitData.isUpcoming! ? -1 : 0,
              status: visitData.status));
        } else {
          final bloc = event.context.read<TodaysPlanBlocSupervisor>();
          bloc.add(SetPlanType(
              selectedTab: visitData.forOwn! ? 0 : 1,
              selectedDateDropdown: visitData.isUpcoming! ? -1 : 0,
              status: visitData.status));
        }
      }
    });
  }

  FutureOr<void> _isSupervisor(
      IsSupervisor event, Emitter<TodaysPlanState> emit) async {
    emit(state.copyWith(
        isSupervisor:
            await LocalData.isSupervisor(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<TodaysPlanState> emit) {
    _iFlutterNavigator.pop();
  }

  FutureOr<void> _setPlanListType(
      SetPlanType event, Emitter<TodaysPlanState> emit) {
    emit(state.copyWith(
        planListType: planListTypeValues[event.planListType],
        selectedTab: event.selectedTab ?? state.selectedTab));
  }

  FutureOr<void> _tabChanged(TabChanged event, Emitter<TodaysPlanState> emit) {
    emit(state.copyWith(selectedTab: event.index));
    if (event.index == 0) {
      final bloc = event.context.read<TodaysPlanBlocOwn>();
      bloc.add(SetPlanType(selectedTab: event.index));
    } else {
      final bloc = event.context.read<TodaysPlanBlocSupervisor>();
      bloc.add(SetPlanType(selectedTab: event.index));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<TodaysPlanState> emit) {
    if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.pop();
    } else if (event.name == PopUpMenu.createNewPlan.name) {
      add(GoToCreateNewPlan(context: event.context));
    }
  }

  FutureOr<void> _changeTab(ChangeTab event, Emitter<TodaysPlanState> emit) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  FutureOr<void> _updateLoader(
      UpdateLoader event, Emitter<TodaysPlanState> emit) {
    if (event.loading != state.isLoading) {
      emit(state.copyWith(isLoading: event.loading));
    }
  }
}
