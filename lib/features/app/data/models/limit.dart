class Limit {
  Limit({
    this.limit,
  });

  final int? limit;

  factory Limit.fromJson(Map<String, dynamic> json) => Limit(
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
      };
}
