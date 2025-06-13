class AreaVisitSave {
  final List<String> objectives;
  final int planId;
  final int companyUnitId;
  final int unitTypeId;
  final String visitNote;

  AreaVisitSave({
    required this.objectives,
    required this.planId,
    required this.companyUnitId,
    required this.unitTypeId,
    required this.visitNote,
  });

  factory AreaVisitSave.fromJson(Map<String, dynamic> json) => AreaVisitSave(
        objectives: List<String>.from(json["objectives"].map((x) => x)),
        planId: json["plan_id"],
        companyUnitId: json["company_unit_id"],
        unitTypeId: json["unit_type_id"],
        visitNote: json["visit_note"],
      );

  Map<String, dynamic> toJson() => {
        "objectives": List<dynamic>.from(objectives.map((x) => x)),
        "plan_id": planId,
        "company_unit_id": companyUnitId,
        "unit_type_id": unitTypeId,
        "visit_note": visitNote,
      };
}
