import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/form_validator/validator.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/user.dart';
import 'package:work_diary/features/app/data/models/verify_otp.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/verify_otp_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/new_password/view/new_password.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(OtpInitial()) {
    on<UpdateUserName>(_updateUserName);
    on<OtpOneChanged>(_otpOneChanged);
    on<OtpTwoChanged>(_otpTwoChanged);
    on<OtpThreeChanged>(_otpThreeChanged);
    on<OtpFourChanged>(_otpFourChanged);
    on<OtpFiveChanged>(_otpFiveChanged);
    on<OtpSixChanged>(_otpSixChanged);
    on<SubmitOtp>(_submitOtp);
    on<ResendOTP>(_resendOtp);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _updateUserName(UpdateUserName event, Emitter<OtpState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  FutureOr<void> _otpOneChanged(OtpOneChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpOne: event.text));
    if (event.text.isNotEmpty && state.otpTwo.isEmpty) {
      FocusTo(focusNode: event.nextFocus, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _otpTwoChanged(OtpTwoChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpTwo: event.text));
    if (event.text.isNotEmpty && state.otpThree.isEmpty) {
      FocusTo(focusNode: event.nextFocus, navigator: _iFlutterNavigator);
    } else {
      FocusTo(focusNode: event.prevFocus, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _otpThreeChanged(
      OtpThreeChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpThree: event.text));
    if (event.text.isNotEmpty && state.otpFour.isEmpty) {
      FocusTo(focusNode: event.nextFocus, navigator: _iFlutterNavigator);
    } else {
      FocusTo(focusNode: event.prevFocus, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _otpFourChanged(OtpFourChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpFour: event.text));
    if (event.text.isNotEmpty && state.otpFive.isEmpty) {
      FocusTo(focusNode: event.nextFocus, navigator: _iFlutterNavigator);
    } else {
      FocusTo(focusNode: event.prevFocus, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _otpFiveChanged(OtpFiveChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpFive: event.text));
    if (event.text.isNotEmpty && state.otpSix.isEmpty) {
      FocusTo(focusNode: event.nextFocus, navigator: _iFlutterNavigator);
    } else {
      FocusTo(focusNode: event.prevFocus, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _otpSixChanged(OtpSixChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpSix: event.text));
    if (event.text.isEmpty) {
      FocusTo(focusNode: event.prevFocus, navigator: _iFlutterNavigator);
    } else {
      FocusScope.of(_iFlutterNavigator.context).requestFocus(FocusNode());
    }
  }

  FutureOr<void> _submitOtp(SubmitOtp event, Emitter<OtpState> emit) async {
    if (isValid(event) && !state.loading) {
      final otp = state.otpOne +
          state.otpTwo +
          state.otpThree +
          state.otpFour +
          state.otpFive +
          state.otpSix;

      emit(state.copyWith(loading: true));

      final verifyResponse = await _apiRepo.post(
          endpoint: verifyOtpEndpoint,
          body: VerifyOtp(username: state.userName, otp: otp),
          token: '',
          responseModel: VerifyOtpResponse());
      emit(state.copyWith(loading: false));

      if (verifyResponse != null) {
        _localStorageRepo.write(key: tokenDB, value: verifyResponse.token!);
        _iFlutterNavigator.push(NewPasswordScreen.route());
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(SubmitOtp event) {
    if (!Validator.isValidated(items: [
      FormItem(text: state.otpOne, focusNode: event.one),
      FormItem(text: state.otpTwo, focusNode: event.two),
      FormItem(text: state.otpThree, focusNode: event.three),
      FormItem(text: state.otpFour, focusNode: event.four),
      FormItem(text: state.otpFive, focusNode: event.five),
      FormItem(text: state.otpSix, focusNode: event.six)
    ], navigator: _iFlutterNavigator)) {
      return false;
    }
    return true;
  }

  FutureOr<void> _resendOtp(ResendOTP event, Emitter<OtpState> emit) {
    _apiRepo.post(
        endpoint: sendOtpEndpoint,
        body: User(username: state.userName),
        token: '',
        responseModel: const DefaultResponse());
  }
}
