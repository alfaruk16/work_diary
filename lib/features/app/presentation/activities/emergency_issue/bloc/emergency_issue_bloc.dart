import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_emergency_issue/view/add_new_emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/complete_emergency_issue_details/view/complete_emergency_issue_details_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc_own.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc_supervisor.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/view/emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue_details/view/emergency_issue_details_screen.dart';

part 'emergency_issue_event.dart';
part 'emergency_issue_state.dart';

class EmergencyIssueBloc
    extends Bloc<EmergencyIssueEvent, EmergencyIssueState> {
  EmergencyIssueBloc(this._iFlutterNavigator, this._localStorageRepo)
      : super(const EmergencyIssueState()) {
    on<CreateEmergencyIssue>(_createEmergencyIssue);
    on<GoToPlanList>(_goToPlanList);
    on<MenuItemScreens>(_menuItemScreens);
    on<IsSupervisor>(_isSupervisor);
    on<TabChanged>(_tabChanged);
    on<UpdateLoader>(_updateLoader);

    add(IsSupervisor());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _createEmergencyIssue(
      CreateEmergencyIssue event, Emitter<EmergencyIssueState> emit) {
    _iFlutterNavigator.push(AddNewEmergencyIssueScreen.route()).then((value) {
      if (state.selectedTab == 0) {
        final bloc = event.context.read<EmergencyIssueBlocOwn>();
        bloc.add(GetTodaysVisitPlan());
      } else {
        final bloc = event.context.read<EmergencyIssueBlocSupervisor>();
        bloc.add(GetTodaysVisitPlan());
      }
    });
  }

  FutureOr<void> _goToPlanList(
      GoToPlanList event, Emitter<EmergencyIssueState> emit) {
    if (event.planType == "completed") {
      _iFlutterNavigator
          .push(CompleteEmergencyIssueScreen.route(visitData: event.visitData))
          .then((value) => add(GetTodaysVisitPlan()));
    } else if (event.planType == "pending") {
      _iFlutterNavigator
          .push(EmergencyIssueDetailsScreen.route(visitData: event.visitData));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<EmergencyIssueState> emit) {
    if (event.name == PopUpMenu.addNewEmergencyIssue.name) {
      _iFlutterNavigator.push(AddNewEmergencyIssueScreen.route()).then((value) {
        if (state.selectedTab == 0) {
          final bloc = event.context.read<EmergencyIssueBlocOwn>();
          bloc.add(GetTodaysVisitPlan());
        } else {
          final bloc = event.context.read<EmergencyIssueBlocSupervisor>();
          bloc.add(GetTodaysVisitPlan());
        }
      });
    } else if (event.name == PopUpMenu.allEmergencyIssue.name) {
      _iFlutterNavigator.push(EmergencyIssueScreen.route());
    } else if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.pop();
    }
  }

  FutureOr<void> _isSupervisor(
      IsSupervisor event, Emitter<EmergencyIssueState> emit) async {
    emit(state.copyWith(
        isSupervisor:
            await LocalData.isSupervisor(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _tabChanged(
      TabChanged event, Emitter<EmergencyIssueState> emit) {
    emit(state.copyWith(selectedTab: event.selectedTab));
    if (event.selectedTab == 0) {
      final bloc = event.context.read<EmergencyIssueBlocOwn>();
      bloc.add(GetTodaysVisitPlan());
    } else {
      final bloc = event.context.read<EmergencyIssueBlocSupervisor>();
      bloc.add(GetTodaysVisitPlan());
    }
  }

  FutureOr<void> _updateLoader(
      UpdateLoader event, Emitter<EmergencyIssueState> emit) {
    if (event.loading != state.isLoading) {
      emit(state.copyWith(isLoading: event.loading));
    }
  }
}
