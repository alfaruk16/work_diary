class ChangePlanStatus {
  ChangePlanStatus({
    required this.planId,
    required this.status,
    required this.comments,
  });

  final int planId;
  final String status;
  final String comments;

  factory ChangePlanStatus.fromJson(Map<String, dynamic> json) =>
      ChangePlanStatus(
        planId: json["plan_id"],
        status: json["status"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
    "plan_id": planId,
    "status": status,
    "comments": comments,
  };
}
