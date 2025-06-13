import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/view/add_new_plan_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/today_visit_own_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/today_visit_supervisor_bloc.dart';

part 'todays_visit_event.dart';
part 'todays_visit_state.dart';

class TodaysVisitBloc
    extends Bloc<TodaysVisitEvent, TodaysVisitState> {
  TodaysVisitBloc(this._iFlutterNavigator, this._localStorageRepo)
      : super(const TodaysVisitState()) {
    on<IsSupervisor>(_isSupervisor);
    on<GoToCreateNewVisitPlan>(_goToCreateNewVisitPlan);
    on<GoToDashboard>(_goToDashboard);
    on<SetPlanListType>(_setPlanListType);
    on<TabChanged>(_tabChanged);
    on<MenuItemScreens>(_menuItemScreens);
    on<ChangeTab>(_changeTab);
    on<UpdateLoader>(_updateLoader);

    add(IsSupervisor());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  Future<FutureOr<void>> _goToCreateNewVisitPlan(
      GoToCreateNewVisitPlan event, Emitter<TodaysVisitState> emit) async {
    if (await LocalData.hasAreaPlan(localStorageRepo: _localStorageRepo)) {
      _iFlutterNavigator.push(AddNewPlanVisitScreen.route()).then((value) {
        if (value != null) {
          final visitData = value as VisitData;
          if (state.selectedTab != (visitData.forOwn! ? 0 : 1)) {
            add(ChangeTab(tabIndex: visitData.forOwn! ? 0 : 1));
          }
          if (state.selectedTab == 0) {
            final bloc = event.context.read<TodaysVisitBlocOwn>();
            bloc.add(SetPlanListType(
                selectedTab: visitData.forOwn! ? 0 : 1,
                selectedDateDropdown: visitData.isUpcoming! ? -1 : 0,
                status: visitData.status));
          } else {
            final bloc = event.context.read<TodaysVisitBlocSupervisor>();
            bloc.add(SetPlanListType(
                selectedTab: visitData.forOwn! ? 0 : 1,
                selectedDateDropdown: visitData.isUpcoming! ? -1 : 0,
                status: visitData.status));
          }
        }
      });
    } else {
      _iFlutterNavigator.push(AddNewVisitScreen.route()).then((value) {
        if (value != null) {
          final visitData = value as VisitData;
          if (state.selectedTab != (visitData.forOwn! ? 0 : 1)) {
            add(ChangeTab(tabIndex: visitData.forOwn! ? 0 : 1));
          }
          if (state.selectedTab == 0) {
            final bloc = event.context.read<TodaysVisitBlocOwn>();
            bloc.add(SetPlanListType(
                selectedTab: visitData.forOwn! ? 0 : 1,
                selectedDateDropdown: visitData.isUpcoming! ? -1 : 0,
                status: visitData.status));
          } else {
            final bloc = event.context.read<TodaysVisitBlocSupervisor>();
            bloc.add(SetPlanListType(
                selectedTab: visitData.forOwn! ? 0 : 1,
                selectedDateDropdown: visitData.isUpcoming! ? -1 : 0,
                status: visitData.status));
          }
        }
      });
    }
  }

  FutureOr<void> _isSupervisor(
      IsSupervisor event, Emitter<TodaysVisitState> emit) async {
    emit(state.copyWith(
        isSupervisor:
            await LocalData.isSupervisor(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<TodaysVisitState> emit) {
    _iFlutterNavigator.pop();
  }

  FutureOr<void> _setPlanListType(
      SetPlanListType event, Emitter<TodaysVisitState> emit) {
    emit(state.copyWith(
        planListType: planListTypeValues[event.planListType],
        selectedTab: event.selectedTab ?? state.selectedTab));
  }

  FutureOr<void> _tabChanged(
      TabChanged event, Emitter<TodaysVisitState> emit) {
    emit(state.copyWith(selectedTab: event.index));
    if (event.index == 0) {
      final bloc = event.context.read<TodaysVisitBlocOwn>();
      bloc.add(SetPlanListType(selectedTab: event.index));
    } else {
      final bloc = event.context.read<TodaysVisitBlocSupervisor>();
      bloc.add(SetPlanListType(selectedTab: event.index));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<TodaysVisitState> emit) {
    if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.pop();
    } else if (event.name == PopUpMenu.createNewVisitPlan.name) {
      add(GoToCreateNewVisitPlan(context: event.context));
    }
  }

  FutureOr<void> _changeTab(
      ChangeTab event, Emitter<TodaysVisitState> emit) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  FutureOr<void> _updateLoader(
      UpdateLoader event, Emitter<TodaysVisitState> emit) {
    if (event.loading != state.isLoading) {
      emit(state.copyWith(isLoading: event.loading));
    }
  }
}
