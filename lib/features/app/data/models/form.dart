class FormModel {
  FormModel({
    required this.visitId,
    required this.formId,
    this.visitFormId,
  });

  final int visitId;
  final int formId;
  final int? visitFormId;

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        visitId: json["visit_id"],
        formId: json["form_id"],
        visitFormId: json["visit_form_id"],
      );

  Map<String, dynamic> toJson() => {
        "visit_id": visitId,
        "form_id": formId,
        "visit_form_id": visitFormId,
      };
}
