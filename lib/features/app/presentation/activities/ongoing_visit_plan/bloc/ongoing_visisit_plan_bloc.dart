import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/complete_slot.dart';
import 'package:work_diary/features/app/data/models/id.dart';
import 'package:work_diary/features/app/data/models/visit_confirmation.dart';
import 'package:work_diary/features/app/data/models/visit_form_delete.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_confirmation_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/form/view/form_screen.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/widget/complete_slot.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/widget/form_delete_confirmation.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/widget/confirmation_modal.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/view/add_new_plan_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/slot/view/slot_screen.dart';

part 'ongoing_visisit_plan_event.dart';
part 'ongoing_visisit_plan_state.dart';

class OngoingVisitPlanBloc
    extends Bloc<OngoingVisitPlanEvent, OngoingVisitPlanState> {
  OngoingVisitPlanBloc(this._iFlutterNavigator, this._apiRepo,
      this._getLocationRepo, this._localStorageRepo)
      : super(OngoingVisitPlanInitial()) {
    on<OnGoingVisitById>(_onGoingVisitById);
    on<GoToForm>(_goToForm);
    on<CheckVisitForms>(_checkVisitForms);
    on<ShowModal>(_showModal);
    on<CompleteVisit>(_completeVisit);
    on<GoToTodaysVisit>(_goToTodaysVisit);
    on<VisitFormDeleteEvent>(_visitFormDeleteEvent);
    on<GoToCreateNewVisitPlan>(_goToCreateNewVisitPlan);
    on<GoToDashboard>(_goToDashboard);
    on<AddData>(_addData);
    on<EditSlot>(_editSlot);
    on<CompleteSlot>(_completeSlot);
    on<EditForm>(_editForm);
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final GetLocationRepo _getLocationRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _onGoingVisitById(
      OnGoingVisitById event, Emitter<OngoingVisitPlanState> emit) async {
    if (state.visitId == -1) {
      emit(state.copyWith(
          visitId: event.visitData.id,
          visit: CompleteVisitResponse(visitData: event.visitData),
          loading: true));
    }
    final onGoingResponse = await _apiRepo.post(
      endpoint: visitsShowEndpoint,
      body: VisitId(id: event.visitData.id!),
      responseModel: const CompleteVisitResponse(),
    );
    emit(state.copyWith(loading: false));
    if (onGoingResponse != null) {
      emit(state.copyWith(visit: onGoingResponse));
    }
  }

  FutureOr<void> _goToForm(
      GoToForm event, Emitter<OngoingVisitPlanState> emit) {
    if (!event.visitData.isSlotEnabled! || event.visitData.slot != null) {
      _iFlutterNavigator
          .push(FormsScreen.route(
              formItem: event.formItem, visitData: event.visitData))
          .then((value) =>
              add(OnGoingVisitById(visitData: state.visit.visitData!)));
    } else {
      _iFlutterNavigator
          .push(SlotScreen.route(visitData: event.visitData))
          .then((value) =>
              add(OnGoingVisitById(visitData: state.visit.visitData!)));
    }
  }

  FutureOr<void> _checkVisitForms(
      CheckVisitForms event, Emitter<OngoingVisitPlanState> emit) async {
    if (!state.loading) {
      emit(state.copyWith(loading: true));

      final formListResponse = await _apiRepo.post(
        endpoint: visitsCompletePrerequisitEndpoint,
        body: Id(id: event.visitId),
        responseModel: const VisitConfirmationResponse(),
      );

      emit(state.copyWith(loading: false));

      if (formListResponse != null) {
        add(ShowModal(
            visitConfirmationResponse: formListResponse,
            visitId: event.visitId));
      }
    }
  }

  FutureOr<void> _showModal(
      ShowModal event, Emitter<OngoingVisitPlanState> emit) {
    confirmModal(
      _iFlutterNavigator.context,
      id: event.visitId,
      formList: event.visitConfirmationResponse,
      confirmBtn: () {
        add(CompleteVisit(visitId: event.visitId));
      },
    );
  }

  FutureOr<void> _completeVisit(
      CompleteVisit event, Emitter<OngoingVisitPlanState> emit) async {
    if (!state.loading) {
      emit(state.copyWith(loading: true));

      final locationData = await _getLocationRepo.getLocation();

      if (locationData != null) {
        final address = await _getLocationRepo.getAddress(
            lat: locationData.latitude!, lng: locationData.longitude!);

        if (address != null) {
          final completeResponse = await _apiRepo.post(
            endpoint: visitsCompleteEndpoint,
            body: VisitConfirmation(
                id: event.visitId,
                lat: locationData.latitude.toString(),
                long: locationData.longitude.toString(),
                address: address,
                confirmBtn: true),
            responseModel: const VisitConfirmationResponse(),
          );
          emit(state.copyWith(loading: false));
          if (completeResponse != null) {
            ShowSnackBar(
                message: completeResponse.message!,
                navigator: _iFlutterNavigator);
            for (int i = 0; i < state.visit.formList!.length; i++) {
              final databaseKey =
                  formDB + state.visit.formList![i]!.id!.toString();
              FormsResponse? form = await _localStorageRepo.readModel(
                  key: databaseKey, model: const FormsResponse());
              if (form != null) {
                form.formList!.visitForms = null;
                await _localStorageRepo.writeModel(
                    key: databaseKey, value: form);
              }
            }
            _iFlutterNavigator.pop(true);
          }
        } else {
          emit(state.copyWith(loading: false));
          ShowSnackBar(
              message: 'Location Not Found',
              navigator: _iFlutterNavigator,
              color: Colors.black);
        }
      } else {
        emit(state.copyWith(loading: false));
        ShowSnackBar(
            message: 'Location Not Found',
            navigator: _iFlutterNavigator,
            color: Colors.black);
      }
    }
  }

  FutureOr<void> _goToTodaysVisit(
      GoToTodaysVisit event, Emitter<OngoingVisitPlanState> emit) {
    _iFlutterNavigator.pop(true);
  }

  FutureOr<void> _visitFormDeleteEvent(
      VisitFormDeleteEvent event, Emitter<OngoingVisitPlanState> emit) {
    formDeleteConfirmation(
      _iFlutterNavigator.context,
      getYes: (bool val) async {
        if (val) {
          final visitFormDeleteResponse = await _apiRepo.post(
            endpoint: visitsFormDeleteEndpoint,
            body: VisitFormDelete(
                id: event.id, formId: event.formId, visitId: event.visitId),
            responseModel: const DefaultResponse(),
          );
          final databaseKey = formDB + event.formId.toString();
          final form = await _localStorageRepo.readModel(
              key: databaseKey, model: const FormsResponse());
          if (form != null) {
            for (int i = 0; i < form.formList!.visitForms!.length; i++) {
              if (form.formList!.visitForms![i]!.visitFormId! == event.id) {
                form.formList!.visitForms!.removeAt(i);
              }
            }
            await _localStorageRepo.writeModel(key: databaseKey, value: form);
          }
          if (visitFormDeleteResponse != null) {
            add(OnGoingVisitById(visitData: state.visit.visitData!));
          }
        }
      },
    );
  }

  Future<FutureOr<void>> _goToCreateNewVisitPlan(
      GoToCreateNewVisitPlan event, Emitter<OngoingVisitPlanState> emit) async {
    if (await LocalData.hasAreaPlan(
        localStorageRepo: getIt<LocalStorageRepo>())) {
      _iFlutterNavigator.push(AddNewPlanVisitScreen.route());
    } else {
      _iFlutterNavigator.push(AddNewVisitScreen.route());
    }
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<OngoingVisitPlanState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  FutureOr<void> _addData(AddData event, Emitter<OngoingVisitPlanState> emit) {
    emit(state.copyWith(
        visit: CompleteVisitResponse(visitData: event.visitData)));
  }

  FutureOr<void> _editSlot(
      EditSlot event, Emitter<OngoingVisitPlanState> emit) {
    _iFlutterNavigator
        .push(SlotScreen.route(visitData: state.visit.visitData!))
        .then((value) =>
            add(OnGoingVisitById(visitData: state.visit.visitData!)));
  }

  FutureOr<void> _completeSlot(
      CompleteSlot event, Emitter<OngoingVisitPlanState> emit) {
    completeSlotDialogue(_iFlutterNavigator.context,
        slot: state.visit.visitData!.slot!, confirmBtn: () async {
      final slotComplete = await _apiRepo.post(
          endpoint: visitsSlotCompleteEndpoint,
          body: CompleteSlotModel(
              id: state.visit.visitData!.slot!.id!, visitId: state.visitId),
          responseModel: const DefaultResponse());
      if (slotComplete != null) {
        ShowSnackBar(
            navigator: _iFlutterNavigator, message: slotComplete.message!);
      }
    });
  }

  FutureOr<void> _editForm(
      EditForm event, Emitter<OngoingVisitPlanState> emit) {
    _iFlutterNavigator
        .push(FormsScreen.route(
            formItem: event.formItem, visitData: event.visitData, visitFormId: event.visitFormId))
        .then((value) =>
            add(OnGoingVisitById(visitData: state.visit.visitData!)));
  }
}
