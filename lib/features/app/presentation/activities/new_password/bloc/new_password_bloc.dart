import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/form_validator/validator.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/reset_password.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/login/view/log_in_screen.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(const NewPasswordState()) {
    on<PasswordChanged>(_passwordChanged);
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<ResetPasswordPressed>(_resetPasswordPressed);
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _passwordChanged(
      PasswordChanged event, Emitter<NewPasswordState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _confirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<NewPasswordState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  FutureOr<void> _resetPasswordPressed(
      ResetPasswordPressed event, Emitter<NewPasswordState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));

      final resetPasswordResponse = await _apiRepo.post(
        endpoint: resetPassword,
        body: ResetPassword(
            password: state.password,
            passwordConfirmation: state.confirmPassword,
            token: _localStorageRepo.read(key: tokenDB)!),
        responseModel: const DefaultResponse(),
      );
      emit(state.copyWith(loading: false));
      if (resetPasswordResponse != null) {
        ShowSnackBar(
          message: resetPasswordResponse.message!,
          navigator: _iFlutterNavigator,
        );
        _iFlutterNavigator.pushReplacement(LogInScreen.route());
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(ResetPasswordPressed event) {
    if (!Validator.isValidated(items: [
      FormItem(text: state.password, focusNode: event.passwordFocusNode),
      FormItem(
          text: state.confirmPassword,
          focusNode: event.confirmPasswordFocusNode)
    ], navigator: _iFlutterNavigator)) {
      return false;
    }

    if (state.password != state.confirmPassword) {
      ShowSnackBar(
          message: "Password not matched",
          navigator: _iFlutterNavigator,
          error: true);
      return false;
    }
    return true;
  }
}
