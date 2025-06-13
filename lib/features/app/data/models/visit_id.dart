class VisitId {
  const VisitId({
    required this.id,
    this.companyId,
  });

  final int id;
  final int? companyId;

  factory VisitId.fromJson(Map<String, dynamic> json) => VisitId(
        id: json["id"],
        companyId: json["company_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
      };
}
