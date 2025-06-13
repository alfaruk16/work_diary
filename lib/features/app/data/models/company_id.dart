class CompanyId {
  const CompanyId({
    required this.companyId,
    this.zoneId,
    this.visitorId
  });

  final int companyId;
  final int? zoneId;
  final int? visitorId;

  factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
        companyId: json["company_id"],
        zoneId: json["zone_id"],
        visitorId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "zone_id": zoneId,
        "user_id": visitorId,
      };
}
