import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/change_visit_status.dart';
import 'package:work_diary/features/app/data/models/complete_slot.dart';
import 'package:work_diary/features/app/data/models/emergency_task.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_response.dart';
import 'package:work_diary/features/app/domain/entities/started_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/update_visit.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/check_in_form/view/check_in_form_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/view/emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue_details/view/emergency_issue_details_screen.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/widget/complete_slot.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/view/add_new_plan_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/slot/view/slot_screen.dart';
import 'package:work_diary/features/app/presentation/activities/visit_details/widget/visits_pop_up.dart';

import '../../emergency_issue/widgets/change_status.dart';

part 'visit_details_event.dart';
part 'visit_details_state.dart';

class VisitDetailsBloc extends Bloc<VisitDetailsEvent, VisitDetailsState> {
  VisitDetailsBloc(this._iFlutterNavigator, this._apiRepo)
      : super(StartCheckInVisitPlanInitial()) {
    on<GetVisitId>(_getVisitId);
    on<GoToEmergency>(_goToEmergencyIssue);
    on<StartCheckIn>(_startCheckIn);
    on<TimeChange>(_timeChange);
    on<UpdateTime>(_updateTime);
    on<GetEmergencyVisit>(_getEmergencyVisit);
    on<ShowVisitModal>(_showVisitModal);
    on<EmergencyIssueDetails>(_emergencyIssueDetails);
    on<GetComments>(_getComments);
    on<UpdateStatus>(_updateStatus);
    on<GoToTodayVisitPlan>(_goToTodayVisitPlan);
    on<GoToCreateNewVisitPlan>(_goToCreateNewVisitPlan);
    on<GoToDashboard>(_goToDashboard);
    on<EditSlot>(_editSlot);
    on<CompleteSlot>(_completeSlot);

    add(TimeChange());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;

  FutureOr<void> _getVisitId(
      GetVisitId event, Emitter<VisitDetailsState> emit) async {
    if (!state.loading) {
      emit(state.copyWith(
          visitDetails: CompleteVisitResponse(visitData: event.visitData),
          loading: true));

      final visitResponse = await _apiRepo.post(
        endpoint: visitsShowEndpoint,
        body: VisitId(id: state.visitDetails.visitData!.id!),
        responseModel: const CompleteVisitResponse(),
      );

      emit(state.copyWith(loading: false));

      if (visitResponse != null) {
        emit(state.copyWith(visitDetails: visitResponse));
        add(GetEmergencyVisit());
      }
    }
  }

  FutureOr<void> _goToEmergencyIssue(
      GoToEmergency event, Emitter<VisitDetailsState> emit) {
    _iFlutterNavigator.push(EmergencyIssueScreen.route());
  }

  FutureOr<void> _startCheckIn(
      StartCheckIn event, Emitter<VisitDetailsState> emit) async {
    if (!state.startLoading) {
      emit(state.copyWith(startLoading: true));

      final startedVisitsResponse = await _apiRepo.post(
        endpoint: visitsStartEndpoint,
        body: VisitId(id: state.visitDetails.visitData!.id!),
        responseModel: const StartedVisitList(),
      );
      emit(state.copyWith(startLoading: false));

      if (startedVisitsResponse != null) {
        emit(state.copyWith(startedVisitList: startedVisitsResponse));
        add(ShowVisitModal(
          unitCode: event.unitCode,
          unitName: event.unitName,
        ));
      }
    }
  }

  FutureOr<void> _showVisitModal(
      ShowVisitModal event, Emitter<VisitDetailsState> emit) {
    visitsPopUp(
      _iFlutterNavigator.context,
      startedVisits: state.startedVisitList,
      confirmStart: () {
        _iFlutterNavigator.push(
            CheckInFormScreen.route(visitData: state.visitDetails.visitData!));
      },
    );
  }

  FutureOr<void> _timeChange(
      TimeChange event, Emitter<VisitDetailsState> emit) {
    add(UpdateTime());
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!isClosed) {
        add(UpdateTime());
      }
    });
  }

  FutureOr<void> _updateTime(
      UpdateTime event, Emitter<VisitDetailsState> emit) {
    emit(state.copyWith(
        time: DateFormat('hh:mm a').format(DateTime.now()),
        day: DateFormat('EEEE, MMMM dd, yyyy').format(DateTime.now())));
  }

// Get Emergency Visit
  FutureOr<void> _getEmergencyVisit(
      GetEmergencyVisit event, Emitter<VisitDetailsState> emit) async {
    final visitPlanResponse = await _apiRepo.post(
      endpoint: "$getEmergencyTasksEndpoint?page=${state.page}",
      body: EmergencyTask(
        // dateFor:
        //     '${DateFormat("yyyy-MM-dd").format(DateTime.now())}|${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
        status: "pending",
        companyUnitId: state.visitDetails.visitData!.companyUnitId,
      ),
      responseModel: const EmergencyTaskResponse(),
    );

    if (visitPlanResponse != null) {
      emit(state.copyWith(emergencyIssue: visitPlanResponse));
    }
  }

  FutureOr<void> _emergencyIssueDetails(
      EmergencyIssueDetails event, Emitter<VisitDetailsState> emit) {
    _iFlutterNavigator
        .push(EmergencyIssueDetailsScreen.route(visitData: event.visitData));
  }

  FutureOr<void> _getComments(
      GetComments event, Emitter<VisitDetailsState> emit) {
    changeStatus(
      _iFlutterNavigator.context,
      getComment: (value) {
        _iFlutterNavigator.pop();
        add(UpdateStatus(id: event.id, status: event.status, commnents: value));
      },
    );
  }

  FutureOr<void> _updateStatus(
      UpdateStatus event, Emitter<VisitDetailsState> emit) async {
    if (!state.cancelLoading) {
      emit(state.copyWith(cancelLoading: true));

      final statusResponse = await _apiRepo.post(
        endpoint: changeStatusEndpoint,
        body: ChangeVisitStatus(
          visitId: event.id,
          status: event.status,
          comments: event.commnents,
        ),
        responseModel: const UpdateVisit(),
      );

      emit(state.copyWith(cancelLoading: false));

      if (statusResponse != null) {
        _iFlutterNavigator.pop(statusResponse.data);
      }
    }
  }

  FutureOr<void> _goToTodayVisitPlan(
      GoToTodayVisitPlan event, Emitter<VisitDetailsState> emit) {
    _iFlutterNavigator.pop();
  }

  Future<FutureOr<void>> _goToCreateNewVisitPlan(
      GoToCreateNewVisitPlan event, Emitter<VisitDetailsState> emit) async {
    if (await LocalData.hasAreaPlan(
        localStorageRepo: getIt<LocalStorageRepo>())) {
      _iFlutterNavigator.push(AddNewPlanVisitScreen.route());
    } else {
      _iFlutterNavigator.push(AddNewVisitScreen.route());
    }
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<VisitDetailsState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  FutureOr<void> _editSlot(EditSlot event, Emitter<VisitDetailsState> emit) {
    _iFlutterNavigator
        .push(SlotScreen.route(visitData: state.visitDetails.visitData!))
        .then((value) {
      if (!isClosed) {
        add(GetVisitId(visitData: state.visitDetails.visitData!));
      }
    });
  }

  FutureOr<void> _completeSlot(
      CompleteSlot event, Emitter<VisitDetailsState> emit) {
    completeSlotDialogue(_iFlutterNavigator.context,
        slot: state.visitDetails.visitData!.slot!, confirmBtn: () async {
      final slotComplete = await _apiRepo.post(
          endpoint: visitsSlotCompleteEndpoint,
          body: CompleteSlotModel(
              id: state.visitDetails.visitData!.slot!.id!,
              visitId: state.visitDetails.visitData!.id!),
          responseModel: const DefaultResponse());
      if (slotComplete != null) {
        ShowSnackBar(
            navigator: _iFlutterNavigator, message: slotComplete.message!);
      }
    });
  }
}
