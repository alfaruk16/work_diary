part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpOneChanged extends OtpEvent {
  const OtpOneChanged({required this.text, required this.nextFocus});
  final String text;
  final FocusNode nextFocus;
}

class OtpTwoChanged extends OtpEvent {
  const OtpTwoChanged(
      {required this.text, required this.prevFocus, required this.nextFocus});
  final String text;
  final FocusNode prevFocus;
  final FocusNode nextFocus;
}

class OtpThreeChanged extends OtpEvent {
  const OtpThreeChanged(
      {required this.text, required this.prevFocus, required this.nextFocus});
  final String text;
  final FocusNode prevFocus;
  final FocusNode nextFocus;
}

class OtpFourChanged extends OtpEvent {
  const OtpFourChanged(
      {required this.text, required this.prevFocus, required this.nextFocus});
  final String text;
  final FocusNode prevFocus;
  final FocusNode nextFocus;
}

class OtpFiveChanged extends OtpEvent {
  const OtpFiveChanged(
      {required this.text, required this.prevFocus, required this.nextFocus});
  final String text;
  final FocusNode prevFocus;
  final FocusNode nextFocus;
}

class OtpSixChanged extends OtpEvent {
  const OtpSixChanged({required this.text, required this.prevFocus});
  final String text;
  final FocusNode prevFocus;
}

class UpdateUserName extends OtpEvent {
  const UpdateUserName({required this.userName});
  final String userName;
}

class SubmitOtp extends OtpEvent {
  const SubmitOtp(
      {required this.one,
      required this.two,
      required this.three,
      required this.four,
      required this.five,
      required this.six});
  final FocusNode one;
  final FocusNode two;
  final FocusNode three;
  final FocusNode four;
  final FocusNode five;
  final FocusNode six;
}

class ResendOTP extends OtpEvent {}
