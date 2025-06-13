part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.userName = '',
    this.password = '',
    this.passwordObscure = true,
    this.loading = false,
    this.forms = Forms.initial,
  });

  final String userName;
  final String password;
  final bool passwordObscure;
  final bool loading;
  final Forms forms;

  LoginState copyWith(
      {String? userName,
      String? password,
      bool? passwordVisibility,
      bool? loading,
      Forms? forms}) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      passwordObscure: passwordVisibility ?? passwordObscure,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
    );
  }

  @override
  List<Object?> get props =>
      [userName, password, passwordObscure, loading, forms];
}

class LoginInitialState extends LoginState {}
