part of 'new_password_bloc.dart';

abstract class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends NewPasswordEvent {
  const PasswordChanged({required this.password});
  final String password;
}

class ConfirmPasswordChanged extends NewPasswordEvent {
  const ConfirmPasswordChanged({required this.confirmPassword});
  final String confirmPassword;
}

class ResetPasswordPressed extends NewPasswordEvent {
  const ResetPasswordPressed(
      {required this.passwordFocusNode,
      required this.confirmPasswordFocusNode});
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
}
