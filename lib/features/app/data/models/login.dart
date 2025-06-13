class Login {
  final String? email;
  final String? password;
  final String? deviceName;

  const Login({this.email, this.password, this.deviceName});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        email: json['email'],
        password: json['password'],
        deviceName: json['device_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_name': deviceName,
    };
  }
}
