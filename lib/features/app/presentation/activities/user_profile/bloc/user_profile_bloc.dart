import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/user_phone.dart';
import 'package:work_diary/features/app/domain/entities/user_profile.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/performance_report/view/performance_report_screen.dart';
import 'package:work_diary/features/app/presentation/activities/reset_password/view/reset_password_screen.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/widgets/update_phone.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this._iFlutterNavigator, this._localStorageRepo,
      this._imagePicker, this._apiRepo)
      : super(UserProfileInitial()) {
    on<GoToResetPasswordScreen>(_goToResetPassword);
    on<GetUserProfile>(_getUserProfile);
    on<PickImage>(_pickImage);
    on<EditPhoneEvent>(_editPhoneEvent);
    on<UpdatePhone>(_updatePhone);
    on<GoToPerformance>(_goToPerformance);

    add(GetUserProfile());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final ImagePicker _imagePicker;
  final ApiRepo _apiRepo;

  FutureOr<void> _goToResetPassword(
      GoToResetPasswordScreen event, Emitter<UserProfileState> emit) {
    _iFlutterNavigator.push(ResetPasswordScreen.route());
  }

  FutureOr<void> _getUserProfile(
      GetUserProfile event, Emitter<UserProfileState> emit) async {
    final userProfile = await _localStorageRepo.readModel(
        key: userProfileDB, model: const UserDetails());
    if (userProfile != null) {
      emit(state.copyWith(userDetails: userProfile));
    }
  }

  FutureOr<void> _pickImage(
      PickImage event, Emitter<UserProfileState> emit) async {
    final XFile? attachments = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    if (attachments != null) {
      emit(state.copyWith(
          attachments: [ImageFile(name: 'avatar', file: attachments)]));
      final uploadImage = await _apiRepo.multipart(
          endpoint: usersEditAvatarEndpoint,
          files: state.attachments,
          responseModel: const UserDetails());

      if (uploadImage != null) {
        emit(state.copyWith(userDetails: uploadImage));
        _localStorageRepo.writeModel(key: userProfileDB, value: uploadImage);
      }
    }
  }

  FutureOr<void> _editPhoneEvent(
      EditPhoneEvent event, Emitter<UserProfileState> emit) {
    showUpdatePhone(
      _iFlutterNavigator.context,
      mobile: state.userDetails.data!.mobile!,
      getPhone: (val) {
        _iFlutterNavigator.pop();
        add(UpdatePhone(number: val));
      },
    );
  }

  FutureOr<void> _updatePhone(
      UpdatePhone event, Emitter<UserProfileState> emit) async {
    final userDetailsData = await _apiRepo.post(
      endpoint: usersEditMobileEndpoint,
      body: UserPhone(
        mobile: event.number,
      ),
      responseModel: const UserDetails(),
    );
    if (userDetailsData != null) {
      _localStorageRepo.writeModel(key: userProfileDB, value: userDetailsData);
    }
    // final getdata = _localStorageRepo.readModel(
    //     key: userProfileDB, model: userDetailsData);

    emit(state.copyWith(userDetails: userDetailsData));
  }

  FutureOr<void> _goToPerformance(
      GoToPerformance event, Emitter<UserProfileState> emit) {
    _iFlutterNavigator
        .push(PerformanceReportScreen.route(visitor: state.userDetails));
  }
}
