import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';

part 'completed_visit_plan_event.dart';
part 'completed_visit_plan_state.dart';

class CompletedVisitPlanBloc
    extends Bloc<CompletedVisitPlanEvent, CompletedVisitPlanState> {
  CompletedVisitPlanBloc(this._apiRepo) : super(CompletedVisitPlanInitial()) {
    on<GetVisitDetails>(_getVisitDetails);
  }

  final ApiRepo _apiRepo;

  FutureOr<void> _getVisitDetails(
      GetVisitDetails event, Emitter<CompletedVisitPlanState> emit) async {
    emit(state.copyWith(
        visit: CompleteVisitResponse(visitData: event.visitData),
        loading: true));
    final visitResponse = await _apiRepo.post(
      endpoint: visitsShowEndpoint,
      body: VisitId(id: event.visitData.id!),
      responseModel: const CompleteVisitResponse(),
    );
    emit(state.copyWith(loading: false));
    if (visitResponse != null) {
      emit(state.copyWith(visit: visitResponse));
    }
  }
}
