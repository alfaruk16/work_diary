class CreateEmergencyTask {
  const CreateEmergencyTask({
    required this.objectives,
    required this.unitTypeId,
    required this.companyUnitId,
    required this.dateFor,
    this.assignTo,
    this.taskNote,
  });

  final List<String> objectives;
  final int unitTypeId;
  final int companyUnitId;
  final String dateFor;
  final int? assignTo;
  final String? taskNote;

  factory CreateEmergencyTask.fromJson(Map<String, dynamic> json) =>
      CreateEmergencyTask(
        objectives: List<String>.from(json["objectives"].map((x) => x)),
        unitTypeId: json["unit_type_id"],
        companyUnitId: json["company_unit_id"],
        dateFor: json["date_for"],
        assignTo: json["assign_to"],
        taskNote: json["task_note"],
      );

  Map<String, dynamic> toJson() => {
        "objectives": List<dynamic>.from(objectives.map((x) => x)),
        "unit_type_id": unitTypeId,
        "company_unit_id": companyUnitId,
        "date_for": dateFor,
        "assign_to": assignTo,
        "task_note": taskNote,
      };
}
