class GetPlan {
  final int companyId;
  final String? plansFor;

  GetPlan({
    required this.companyId,
    required this.plansFor,
  });

  factory GetPlan.fromJson(Map<String, dynamic> json) => GetPlan(
        companyId: json["company_id"],
        plansFor: json["plans_for"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "plans_for": plansFor,
      };
}
