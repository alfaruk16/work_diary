part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserNameChanged extends LoginEvent {
  const UserNameChanged({required this.userName});
  final String userName;
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});
  final String password;
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    required this.userNameFocusNode,
    required this.passwordFocusNode,
  });
  final FocusNode userNameFocusNode;
  final FocusNode passwordFocusNode;
}

class PasswordVisibility extends LoginEvent {
  const PasswordVisibility({required this.visibility});
  final bool visibility;
}

class ForgotPassword extends LoginEvent {}
