import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/visit_id.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_details_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';

part 'emergency_issue_details_event.dart';
part 'emergency_issue_details_state.dart';

class EmergencyIssueDetailsBloc
    extends Bloc<EmergencyIssueDetailsEvent, EmergencyIssueDetailsState> {
  EmergencyIssueDetailsBloc(this._iFlutterNavigator, this._getLocationRepo,
      this._imagePicker, this._apiRepo, this._localStorageRepo)
      : super(const EmergencyIssueDetailsState()) {
    on<PickImage>(_pickImage);
    on<GetEmergencyIssueId>(_getEmergencyIssueId);
    on<GetComments>(_getComments);
    on<CompleteEmergencyIssue>(_completeEmergencyIssue);
    on<GotToIssueList>(_gotToIssueList);
    on<MenuItemScreens>(_menuItemScreens);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final GetLocationRepo _getLocationRepo;
  final ImagePicker _imagePicker;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _pickImage(
      PickImage event, Emitter<EmergencyIssueDetailsState> emit) async {
    XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);
    if (file != null) {
      emit(state.copyWith(
          images: List.from(state.images)
            ..add(ImageFile(name: 'images[]', file: file))));
    }
  }

//Get Emergency Issue Details by ID
  FutureOr<void> _getEmergencyIssueId(GetEmergencyIssueId event,
      Emitter<EmergencyIssueDetailsState> emit) async {
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
            await LocalData.getCompanyId(localStorageRepo: _localStorageRepo),
        loading: true));

    final emergencyIssueDetailsResponse = await _apiRepo.post(
      endpoint: emergencyTasksDetailsEndpoint,
      body: VisitId(
        id: event.visitData.id!,
        companyId: state.companyId,
      ),
      responseModel: const EmergencyTaskDetails(),
    );
    emit(state.copyWith(loading: false));
    if (emergencyIssueDetailsResponse != null) {
      emit(state.copyWith(emergencyTaskDetails: emergencyIssueDetailsResponse));
    }
  }

  FutureOr<void> _getComments(
      GetComments event, Emitter<EmergencyIssueDetailsState> emit) {
    emit(state.copyWith(comments: event.comments));
  }

//Save Issue
  FutureOr<void> _completeEmergencyIssue(CompleteEmergencyIssue event,
      Emitter<EmergencyIssueDetailsState> emit) async {
    if (state.images.isNotEmpty) {
      if (!state.loading) {
        emit(state.copyWith(loading: true));

        final locationData = await _getLocationRepo.getLocation();

        if (locationData != null) {
          final address = await _getLocationRepo.getAddress(
              lat: locationData.latitude!, lng: locationData.longitude!);

          if (address != null) {
            Map<String, String> body = {
              "id": state.issueId.toString(),
              "company_id": state.companyId.toString(),
              "comments": state.comments.toString(),
              "lat": locationData.latitude.toString(),
              "long": locationData.longitude.toString(),
              "address": address,
            };

            final saveData = await _apiRepo.multipart(
              endpoint: emergencyTasksCompleteEndpoint,
              body: body,
              files: state.images,
              responseModel: const DefaultResponse(),
            );

            if (saveData != null) {
              _iFlutterNavigator.pop();
            }
          } else {
            emit(state.copyWith(loading: false));
            ShowSnackBar(
                message: 'Location Not Found, Please Try Again',
                navigator: _iFlutterNavigator,
                color: Colors.black);
          }
        } else {
          emit(state.copyWith(loading: false));
          ShowSnackBar(
              message: 'Location Not Found, Please Try Again',
              navigator: _iFlutterNavigator,
              color: Colors.black);
        }
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _gotToIssueList(
      GotToIssueList event, Emitter<EmergencyIssueDetailsState> emit) {
    _iFlutterNavigator.pop();
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<EmergencyIssueDetailsState> emit) {
    if (event.name == PopUpMenu.allEmergencyIssue.name) {
      _iFlutterNavigator.pop();
    }
  }
}
