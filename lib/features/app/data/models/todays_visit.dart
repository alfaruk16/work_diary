class TodaysVisits {
  const TodaysVisits(
      {required this.dateFor,
      this.status,
      this.companyId,
      this.visitsFor,
      this.visitorId});

  final int? companyId;
  final String dateFor;
  final String? status;
  final String? visitsFor;
  final int? visitorId;

  factory TodaysVisits.fromJson(Map<String, dynamic> json) => TodaysVisits(
        companyId: json["company_id"],
        dateFor: json["date_for"],
        status: json["status"],
        visitsFor: json["visits_for"],
        visitorId: json["visitor_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "date_for": dateFor,
        "status": status,
        "visits_for": visitsFor,
        "visitor_id": visitorId,
      };
}
