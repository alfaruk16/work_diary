part of 'otp_bloc.dart';

class OtpState extends Equatable {
  const OtpState(
      {this.userName = '',
      this.otpOne = '',
      this.otpTwo = '',
      this.otpThree = '',
      this.otpFour = '',
      this.otpFive = '',
      this.otpSix = '',
      this.forms = Forms.initial,
      this.loading = false});

  final String userName;
  final String otpOne;
  final String otpTwo;
  final String otpThree;
  final String otpFour;
  final String otpFive;
  final String otpSix;
  final Forms forms;
  final bool loading;

  OtpState copyWith(
      {String? userName,
      String? otpOne,
      String? otpTwo,
      String? otpThree,
      String? otpFour,
      String? otpFive,
      String? otpSix,
      Forms? forms,
      bool? loading}) {
    return OtpState(
        userName: userName ?? this.userName,
        otpOne: otpOne ?? this.otpOne,
        otpTwo: otpTwo ?? this.otpTwo,
        otpThree: otpThree ?? this.otpThree,
        otpFour: otpFour ?? this.otpFour,
        otpFive: otpFive ?? this.otpFive,
        otpSix: otpSix ?? this.otpSix,
        forms: forms ?? this.forms,
        loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [
        userName,
        otpOne,
        otpTwo,
        otpThree,
        otpFour,
        otpFive,
        otpSix,
        forms,
        loading
      ];
}

class OtpInitial extends OtpState {}
