class DealerUnits {
  const DealerUnits({
    this.companyId,
    this.zoneId,
  });

  final int? companyId;
  final int? zoneId;

  factory DealerUnits.fromJson(Map<String, dynamic> json) => DealerUnits(
        companyId: json["company_id"],
        zoneId: json["zone_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "zone_id": zoneId,
      };
}
