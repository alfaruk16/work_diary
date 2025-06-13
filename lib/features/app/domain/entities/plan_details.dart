import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class PlanDetailsResponse {
  const PlanDetailsResponse({
    this.visitData,
    this.formList,
  });

  final VisitData? visitData;
  final List<FormList?>? formList;

  factory PlanDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PlanDetailsResponse(
        visitData: VisitData.fromJson(json["planDetails"]),
        formList: json["formList"] == null
            ? []
            : List<FormList?>.from(
            json["formList"]!.map((x) => FormList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "visitData": visitData!.toJson(),
    "formList": formList == null
        ? []
        : List<dynamic>.from(formList!.map((x) => x!.toJson())),
  };
}