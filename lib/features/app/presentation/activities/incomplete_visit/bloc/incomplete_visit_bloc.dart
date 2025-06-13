import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';

part 'incomplete_visit_event.dart';
part 'incomplete_visit_state.dart';

class IncompleteVisitBloc
    extends Bloc<IncompleteVisitEvent, IncompleteVisitState> {
  IncompleteVisitBloc(this._apiRepo)
      : super(CompletedVisitPlanInitial()) {
    on<GetVisitDetails>(_getVisitDetails);
  }

  final ApiRepo _apiRepo;

  FutureOr<void> _getVisitDetails(
      GetVisitDetails event, Emitter<IncompleteVisitState> emit) async {
    emit(state.copyWith(
        visit: CompleteVisitResponse(visitData: event.visitData)));
    final visitResponse = await _apiRepo.post(
      endpoint: visitsShowEndpoint,
      body: VisitId(id: state.visit.visitData!.id!),
      responseModel: const CompleteVisitResponse(),
    );
    if (visitResponse != null) {
      emit(state.copyWith(visit: visitResponse));
    }
  }
}
