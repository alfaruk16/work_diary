class Performance {
  final int month;
  final int year;
  final int companyId;
  final int userId;

  Performance({
    required this.month,
    required this.year,
    required this.companyId,
    required this.userId,
  });

  factory Performance.fromJson(Map<String, dynamic> json) => Performance(
    month: json["month"],
    year: json["year"],
    companyId: json["company_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "year": year,
    "company_id": companyId,
    "user_id": userId,
  };
}
