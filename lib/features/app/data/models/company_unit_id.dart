class CompanyUnitId {
  const CompanyUnitId({
    required this.companyUnitId,
  });

  final int companyUnitId;

  factory CompanyUnitId.fromJson(Map<String, dynamic> json) => CompanyUnitId(
        companyUnitId: json["company_unit_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_unit_id": companyUnitId,
      };
}
