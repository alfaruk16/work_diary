class VisitFormDelete {
  VisitFormDelete({
    required this.id,
    required this.formId,
    required this.visitId,
  });

  int id;
  int formId;
  int visitId;

  factory VisitFormDelete.fromJson(Map<String, dynamic> json) =>
      VisitFormDelete(
        id: json["id"],
        formId: json["form_id"],
        visitId: json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "form_id": formId,
        "visit_id": visitId,
      };
}
