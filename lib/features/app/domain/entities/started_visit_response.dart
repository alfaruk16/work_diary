import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class StartedVisitList {
  const StartedVisitList({
    this.data,
    this.message,
  });

  final List<VisitData>? data;
  final String? message;

  factory StartedVisitList.fromJson(Map<String, dynamic> json) =>
      StartedVisitList(
        data: List<VisitData>.from(json["data"].map((x) => VisitData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}
