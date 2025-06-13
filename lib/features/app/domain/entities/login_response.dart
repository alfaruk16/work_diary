class LoginResponse {
  final int? error;
  final String? version;
  final int? id;
  final String? token;

  const LoginResponse({this.error, this.version, this.id, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        error: json['error'],
        version: json['version'],
        id: json['id'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'error': error, 'version': version, 'id': id, 'token': token};
  }
}
