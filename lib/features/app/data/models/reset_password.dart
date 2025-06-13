class ResetPassword {
  const ResetPassword({
    required this.token,
    required this.password,
    required this.passwordConfirmation,
  });

  final String token;
  final String password;
  final String passwordConfirmation;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
        token: json["token"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
