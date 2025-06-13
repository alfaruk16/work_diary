class UserId {
  const UserId({
    required this.userId,
    this.related,
  });

  final int userId;
  final bool? related;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        userId: json["user_id"],
        related: json["related"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "related": related,
      };
}
