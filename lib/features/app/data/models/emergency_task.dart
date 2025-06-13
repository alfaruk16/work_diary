class EmergencyTask {
  const EmergencyTask({
    this.companyId,
    this.dateFor,
    this.status,
    this.tasksFor,
    this.companyUnitId,
  });

  final int? companyId;
  final String? dateFor;
  final String? status;
  final String? tasksFor;
  final int? companyUnitId;

  factory EmergencyTask.fromJson(Map<String, dynamic> json) => EmergencyTask(
        companyId: json["company_id"],
        dateFor: json["date_for"],
        status: json["status"],
        tasksFor: json["tasks_for"],
        companyUnitId: json["company_unit_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "date_for": dateFor,
        "status": status,
        "tasks_for": tasksFor,
        "company_unit_id": companyUnitId,
      };
}
