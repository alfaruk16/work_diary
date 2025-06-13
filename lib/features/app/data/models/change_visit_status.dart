class ChangeVisitStatus {
  ChangeVisitStatus({
    required this.visitId,
    required this.status,
    required this.comments,
  });

  final int visitId;
  final String status;
  final String comments;

  factory ChangeVisitStatus.fromJson(Map<String, dynamic> json) =>
      ChangeVisitStatus(
        visitId: json["visit_id"],
        status: json["status"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "visit_id": visitId,
        "status": status,
        "comments": comments,
      };
}
