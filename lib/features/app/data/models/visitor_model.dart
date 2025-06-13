class VisitorModel {
  const VisitorModel({
    required this.companyId,
    required this.userId
  });

  final int companyId;
  final int userId;

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
    companyId: json["company_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "user_id": userId,
  };
}
