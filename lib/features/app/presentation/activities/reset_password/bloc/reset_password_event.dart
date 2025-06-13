part of 'reset_password_bloc.dart';

abstract class SendOtp extends Equatable {
  const SendOtp();

  @override
  List<Object> get props => [];
}

class UserNameChanged extends SendOtp{
  const UserNameChanged({required this.username});
  final String username;
}

class SendOTP extends SendOtp {
  const SendOTP({required this.usernameFocusNode});
  final FocusNode usernameFocusNode;
}
