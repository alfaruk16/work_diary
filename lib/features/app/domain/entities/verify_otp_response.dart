class VerifyOtpResponse {
  VerifyOtpResponse({
    this.message,
    this.token,
  });

  final String? message;
  final String? token;

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
