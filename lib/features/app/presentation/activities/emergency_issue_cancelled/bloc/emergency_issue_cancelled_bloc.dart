import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_details_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';

part 'emergency_issue_cancelled_event.dart';
part 'emergency_issue_cancelled_state.dart';

class EmergencyIssueCancelledBloc
    extends Bloc<EmergencyIssueCancelledEvent, EmergencyIssueCancelledState> {
  EmergencyIssueCancelledBloc(this._iFlutterNavigator, this._apiRepo)
      : super(const EmergencyIssueCancelledState()) {
    on<GetEmergencyIssueId>(_getEmergencyIssueId);
    on<GotToIssueList>(_gotToIssueList);
    on<MenuItemScreens>(_menuItemScreens);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;

  FutureOr<void> _getEmergencyIssueId(GetEmergencyIssueId event,
      Emitter<EmergencyIssueCancelledState> emit) async {
    final data = event.visitData;

    final details = EmergencyTaskDetails(
        data: TaskDtls(
            id: data.id,
            created: data.created,
            status: data.status,
            dateFor: data.dateFor,
            name: data.name,
            canComplete: data.canComplete));

    emit(state.copyWith(emergencyTaskDetails: details, loading: true));

    final emergencyIssueDetailsResponse = await _apiRepo.post(
      endpoint: emergencyTasksDetailsEndpoint,
      body: VisitId(
        id: event.visitData.id!,
      ),
      responseModel: const EmergencyTaskDetails(),
    );
    emit(state.copyWith(loading: false));
    if (emergencyIssueDetailsResponse != null) {
      emit(state.copyWith(emergencyTaskDetails: emergencyIssueDetailsResponse));
    }
  }

  FutureOr<void> _gotToIssueList(
      GotToIssueList event, Emitter<EmergencyIssueCancelledState> emit) {
    _iFlutterNavigator.pop();
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<EmergencyIssueCancelledState> emit) {
    if (event.name == PopUpMenu.allEmergencyIssue.name) {
      _iFlutterNavigator.pop();
    }
  }
}
