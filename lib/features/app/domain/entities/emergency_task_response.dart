import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';

class EmergencyTaskResponse {
  const EmergencyTaskResponse({
    this.data,
    this.meta,
    this.summery,
  });

  final List<VisitData>? data;
  final Meta? meta;
  final Summery? summery;

  factory EmergencyTaskResponse.fromJson(Map<String, dynamic> json) =>
      EmergencyTaskResponse(
        data: List<VisitData>.from(json["data"].map((x) => VisitData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        summery: Summery.fromJson(json["summery"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta!.toJson(),
        "summery": summery!.toJson(),
      };
}

class SummeryData {
  const SummeryData({
    this.status,
    this.total,
  });

  final String? status;
  final int? total;

  factory SummeryData.fromJson(Map<String, dynamic> json) => SummeryData(
        status: json["status"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
      };
}
