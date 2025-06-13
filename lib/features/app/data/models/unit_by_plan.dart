class UnitByPlan {
  final int companyId;
  final int planId;

  UnitByPlan({
    required this.companyId,
    required this.planId,
  });

  factory UnitByPlan.fromJson(Map<String, dynamic> json) => UnitByPlan(
    companyId: json["company_id"],
    planId: json["plan_id"],
  );

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "plan_id": planId,
  };
}
