import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/domain/entities/attendance_response.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/view/add_new_plan_visit_screen.dart';

part 'check_in_form_event.dart';
part 'check_in_form_state.dart';

class CheckInFormBloc extends Bloc<CheckInFormEvent, CheckInFormState> {
  CheckInFormBloc(this._iFlutterNavigator, this._imagePicker,
      this._getLocationRepo, this._apiRepo)
      : super(CheckInFormInitial()) {
    on<PickImage>(_pickImage);
    on<GetId>(_getId);
    on<SaveWithAttendance>(_saveWithAttendance);
    on<GoToTodayVisitPlan>(_goToTodayVisitPlan);
    on<GoToCreateNewVisitPlan>(_goToCreateNewVisitPlan);
    on<GoToDashboard>(_goToDashboard);
    on<CancelAnImage>(_cancelAnImage);

    add(PickImage());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ImagePicker _imagePicker;
  final GetLocationRepo _getLocationRepo;
  final ApiRepo _apiRepo;

  FutureOr<void> _pickImage(
      PickImage event, Emitter<CheckInFormState> emit) async {
    XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);

    if (file != null) {
      emit(state.copyWith(
          images: List.from(state.images)
            ..add(ImageFile(name: 'images[]', file: file))));
    }
  }

  FutureOr<void> _getId(GetId event, Emitter<CheckInFormState> emit) {
    emit(state.copyWith(visitData: event.visitData));
  }

  FutureOr<void> _saveWithAttendance(
      SaveWithAttendance event, Emitter<CheckInFormState> emit) async {
    if (state.images.isNotEmpty) {
      if (!state.loading) {
        emit(state.copyWith(loading: true));

        final locationData = await _getLocationRepo.getLocation();

        if (locationData != null) {
          final address = await _getLocationRepo.getAddress(
              lat: locationData.latitude!, lng: locationData.longitude!);

          if (address != null) {
            Map<String, String> body = {
              "visit_id": state.visitData.id.toString(),
              "company_id": '',
              "lat": locationData.latitude.toString(),
              "long": locationData.longitude.toString(),
              "address": address,
            };

            final saveData = await _apiRepo.multipart(
              endpoint: saveWithAttendanceEndpoint,
              body: body,
              files: state.images,
              responseModel: const AttendanceResponse(),
            );

            emit(state.copyWith(loading: false));

            if (saveData != null) {
              _iFlutterNavigator.pop(state.visitData);
              _iFlutterNavigator.pop(state.visitData);
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

  FutureOr<void> _goToTodayVisitPlan(
      GoToTodayVisitPlan event, Emitter<CheckInFormState> emit) {
    int count = 0;
    _iFlutterNavigator.popUntil((route) => count++ == 2);
  }

  Future<FutureOr<void>> _goToCreateNewVisitPlan(
      GoToCreateNewVisitPlan event, Emitter<CheckInFormState> emit) async {
    if (await LocalData.hasAreaPlan(
        localStorageRepo: getIt<LocalStorageRepo>())) {
      _iFlutterNavigator.push(AddNewPlanVisitScreen.route());
    } else {
      _iFlutterNavigator.push(AddNewVisitScreen.route());
    }
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<CheckInFormState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  FutureOr<void> _cancelAnImage(
      CancelAnImage event, Emitter<CheckInFormState> emit) {
    emit(
        state.copyWith(images: List.from(state.images)..removeAt(event.index)));
  }
}
