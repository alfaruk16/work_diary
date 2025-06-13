class TodaysPlan {
  const TodaysPlan(
      {required this.dateFor,
      this.status,
      this.companyId,
      this.plansFor,
      this.visitorId});

  final int? companyId;
  final String dateFor;
  final String? status;
  final String? plansFor;
  final int? visitorId;

  factory TodaysPlan.fromJson(Map<String, dynamic> json) => TodaysPlan(
        companyId: json["company_id"],
        dateFor: json["date_for"],
        status: json["status"],
        plansFor: json["plans_for"],
        visitorId: json["visitor_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "date_for": dateFor,
        "status": status,
        "plans_for": plansFor,
        "visitor_id": visitorId,
      };
}
