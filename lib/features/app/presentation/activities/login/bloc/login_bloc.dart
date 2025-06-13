import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/form_validator/validator.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/entities/companies.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/login.dart';
import 'package:work_diary/features/app/domain/entities/login_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/view/dashboard_screen.dart';
import 'package:work_diary/features/app/presentation/activities/reset_password/view/reset_password_screen.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._flutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(const LoginState()) {
    on<UserNameChanged>(_userNameChanged);
    on<PasswordChanged>(_passwordChanged);
    on<PasswordVisibility>(_passwordVisibility);
    on<LoginButtonPressed>(_loginButtonPressed);
    on<ForgotPassword>(_forgotPassword);
  }

  final IFlutterNavigator _flutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _userNameChanged(
      UserNameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  FutureOr<void> _passwordChanged(
      PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _passwordVisibility(
      PasswordVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordVisibility: !state.passwordObscure));
  }

  Future<FutureOr<void>> _loginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));

      final loginResponse = await _apiRepo.post(
          endpoint: loginEndpoint,
          body: Login(
              email: state.userName,
              password: state.password,
              deviceName: 'Android'),
          token: '',
          responseModel: const LoginResponse());

      if (loginResponse != null) {
        _localStorageRepo.write(key: tokenDB, value: loginResponse.token!);
        _localStorageRepo.writeModel(
            key: loginResponseDB, value: loginResponse);

        final companies = await _apiRepo.post(
            endpoint: companyEndpoint, responseModel: const Companies());

        if (companies != null) {
          _localStorageRepo.writeModel(key: companiesDB, value: companies);

          if (companies.data!.isNotEmpty) {
            _localStorageRepo.writeModel(
                key: companyDB, value: companies.data![0]);
            _flutterNavigator.pushReplacement(DashBoardScreen.route());
          }
          // else {
          //   _flutterNavigator.pushReplacement(CompaniesScreen.route());
          // }
        }
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(LoginButtonPressed event) {
    if (!Validator.isValidated(items: [
      FormItem(text: state.userName, focusNode: event.userNameFocusNode),
      FormItem(text: state.password, focusNode: event.passwordFocusNode)
    ], navigator: _flutterNavigator)) {
      return false;
    }
    return true;
  }

  FutureOr<void> _forgotPassword(
      ForgotPassword event, Emitter<LoginState> emit) {
    _flutterNavigator.push(ResetPasswordScreen.route());
  }
}
