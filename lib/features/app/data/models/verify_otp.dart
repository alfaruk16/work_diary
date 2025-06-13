class VerifyOtp {
  const VerifyOtp({
    required this.username,
    required this.otp,
  });

  final String username;
  final String otp;

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        username: json["username"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "otp": otp,
      };
}
