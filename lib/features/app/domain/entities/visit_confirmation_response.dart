class VisitConfirmationResponse {
  const VisitConfirmationResponse({
    this.formList,
    this.confirmBtn,
    this.missingString,
    this.message,
  });

  final List<ConfirmFormList?>? formList;
  final bool? confirmBtn;
  final String? missingString;
  final String? message;

  factory VisitConfirmationResponse.fromJson(Map<String, dynamic> json) =>
      VisitConfirmationResponse(
        formList: json["formList"] == null
            ? []
            : List<ConfirmFormList?>.from(
                json["formList"]!.map((x) => ConfirmFormList.fromJson(x))),
        confirmBtn: json["confirmBtn"],
        missingString: json["missing_string"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "formList": formList == null
            ? []
            : List<dynamic>.from(formList!.map((x) => x!.toJson())),
        "confirmBtn": confirmBtn,
        "missing_string": missingString,
        "message": message,
      };
}

class ConfirmFormList {
  ConfirmFormList({
    this.id,
    this.name,
    this.isSkippable,
    this.visitId,
  });

  int? id;
  String? name;
  String? isSkippable;
  dynamic visitId;

  factory ConfirmFormList.fromJson(Map<String, dynamic> json) =>
      ConfirmFormList(
        id: json["id"],
        name: json["name"],
        isSkippable: json["is_skippable"],
        visitId: json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_skippable": isSkippable,
        "visit_id": visitId,
      };
}
