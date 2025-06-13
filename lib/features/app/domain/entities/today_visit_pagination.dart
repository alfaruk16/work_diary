import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';

class TodaysVisitPagination {
  const TodaysVisitPagination({
    this.data,
    this.meta,
  });

  final List<VisitData>? data;
  final Meta? meta;

  factory TodaysVisitPagination.fromJson(Map<String, dynamic> json) =>
      TodaysVisitPagination(
        data: List<VisitData>.from(json["data"].map((x) => VisitData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta!.toJson(),
      };
}
