class ChangeEmergencyIssueStatus {
  const ChangeEmergencyIssueStatus({
    required this.emergencyTaskId,
    this.companyId,
    required this.status,
    this.comments,
  });

  final int emergencyTaskId;
  final int? companyId;
  final String status;
  final String? comments;

  factory ChangeEmergencyIssueStatus.fromJson(Map<String, dynamic> json) =>
      ChangeEmergencyIssueStatus(
        emergencyTaskId: json["emergency_task_id"],
        companyId: json["company_id"],
        status: json["status"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "emergency_task_id": emergencyTaskId,
        "company_id": companyId,
        "status": status,
        "comments": comments,
      };
}
