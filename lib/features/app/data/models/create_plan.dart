class CreatePlan {
  final int zoneId;
  final int? areaId;
  final String dateFor;
  final int assignTo;
  final String comments;

  CreatePlan({
    required this.zoneId,
     this.areaId,
    required this.dateFor,
    required this.assignTo,
    required this.comments,
  });

  factory CreatePlan.fromJson(Map<String, dynamic> json) => CreatePlan(
        zoneId: json["zone_id"],
        areaId: json["area_id"],
        dateFor: json["date_for"],
        assignTo: json["assign_to"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "zone_id": zoneId,
        "area_id": areaId,
        "date_for": dateFor,
        "assign_to": assignTo,
        "comments": comments,
      };
}
