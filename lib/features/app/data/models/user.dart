class User {
  const User({required this.username});
  final String username;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {'username': username};
  }
}
