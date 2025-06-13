import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/form_validator/validator.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/user.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/otp/view/otp_screen.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<SendOtp, ResetPasswordState> {
  ResetPasswordBloc(this._flutterNavigator, this._apiRepo)
      : super(ResetPasswordInitial()) {
    on<UserNameChanged>(_userNameChanged);
    on<SendOTP>(_sendOtp);
  }

  final IFlutterNavigator _flutterNavigator;
  final ApiRepo _apiRepo;

  FutureOr<void> _userNameChanged(
      UserNameChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(username: event.username));
  }

  Future<FutureOr<void>> _sendOtp(
      SendOTP event, Emitter<ResetPasswordState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));

      final otp = await _apiRepo.post(
          endpoint: sendOtpEndpoint,
          body: User(username: state.username),
          token: '',
          responseModel: const DefaultResponse());

      emit(state.copyWith(loading: false));

      if (otp != null) {
        ShowSnackBar(message: otp.message!, navigator: _flutterNavigator);
        _flutterNavigator.push(OtpScreen.route(state.username));
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(SendOTP event) {
    if (!Validator.isValidated(items: [
      FormItem(text: state.username, focusNode: event.usernameFocusNode),
    ], navigator: _flutterNavigator)) {
      return false;
    }
    return true;
  }
}
