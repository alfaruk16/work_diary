import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_details_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';

part 'complete_emergency_issue_details_event.dart';
part 'complete_emergency_issue_details_state.dart';

class CompleteEmergencyIssueDetailsBloc extends Bloc<
    CompleteEmergencyIssueDetailsEvent, CompleteEmergencyIssueDetailsState> {
  CompleteEmergencyIssueDetailsBloc(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(const CompleteEmergencyIssueDetailsState()) {
    on<GoToEmergencyIssueScreen>(_goToEmergencyIssue);
    on<GetIssueId>(_getIssueId);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

//Get Emergency Issue detail by ID
  FutureOr<void> _getIssueId(GetIssueId event,
      Emitter<CompleteEmergencyIssueDetailsState> emit) async {
    final data = event.visitData;

    final details = EmergencyTaskDetails(
        data: TaskDtls(
            id: data.id,
            created: data.created,
            status: data.status,
            dateFor: data.dateFor,
            name: data.name,
            forOwn: data.forOwn,
            canComplete: data.canComplete));

    emit(state.copyWith(
        issueId: event.visitData.id,
        emergencyTaskDetails: details,
        companyId:
            await LocalData.getCompanyId(localStorageRepo: _localStorageRepo), loading: true));

    final completeIssueResponse = await _apiRepo.post(
      endpoint: emergencyTasksDetailsEndpoint,
      body: VisitId(
        id: event.visitData.id!,
        companyId: state.companyId,
      ),
      responseModel: const EmergencyTaskDetails(),
    );
    emit(state.copyWith(loading: false));

    if (completeIssueResponse != null) {
      emit(state.copyWith(emergencyTaskDetails: completeIssueResponse));
    }
  }

  FutureOr<void> _goToEmergencyIssue(GoToEmergencyIssueScreen event,
      Emitter<CompleteEmergencyIssueDetailsState> emit) {
    _iFlutterNavigator.pop();
  }
}
