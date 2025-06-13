part of 'new_password_bloc.dart';

class NewPasswordState extends Equatable {
  const NewPasswordState(
      {this.password = '',
      this.confirmPassword = '',
      this.forms = Forms.initial,
      this.loading = false});

  final String password;
  final String confirmPassword;
  final Forms forms;
  final bool loading;

  NewPasswordState copyWith(
      {String? password,
      String? confirmPassword,
      Forms? forms,
      bool? loading}) {
    return NewPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      forms: forms ?? this.forms,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [password, confirmPassword, forms, loading];
}

class NewPasswordInitial extends NewPasswordState {}
