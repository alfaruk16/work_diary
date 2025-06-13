class Children {
  final int visitId;
  final int formId;
  final int parentId;
  final int parentValue;
  final int? visitFormId;

  Children({
    required this.visitId,
    required this.formId,
    required this.parentId,
    required this.parentValue,
    this.visitFormId,
  });

  factory Children.fromJson(Map<String, dynamic> json) => Children(
        visitId: json["visit_id"],
        formId: json["form_id"],
        parentId: json["parent_id"],
        parentValue: json["parent_value"],
        visitFormId: json["visit_form_id"],
      );

  Map<String, dynamic> toJson() => {
        "visit_id": visitId,
        "form_id": formId,
        "parent_id": parentId,
        "parent_value": parentValue,
        "visit_form_id": visitFormId,
      };
}
