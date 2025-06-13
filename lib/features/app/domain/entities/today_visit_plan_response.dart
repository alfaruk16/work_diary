import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class TodaysVisitResponse {
  const TodaysVisitResponse({
    this.data,
    this.meta,
    this.ongoing,
    this.summery,
  });

  final List<VisitData>? data;
  final Meta? meta;
  final VisitData? ongoing;
  final Summery? summery;

  factory TodaysVisitResponse.fromJson(Map<String, dynamic> json) =>
      TodaysVisitResponse(
        data: List<VisitData>.from(
            json["data"].map((x) => VisitData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        ongoing: json["ongoing"] != null
            ? VisitData.fromJson(json["ongoing"])
            : null,
        summery:
            json["summery"] != null ? Summery.fromJson(json["summery"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta!.toJson(),
        "ongoing": ongoing != null ? ongoing!.toJson() : null,
        "summery": summery!.toJson(),
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Summery {
  Summery({
    this.total,
    this.ongoingCount,
    this.data,
  });

  final int? total;
  final int? ongoingCount;
  final List<Datum>? data;

  factory Summery.fromJson(Map<String, dynamic> json) => Summery(
        total: json["total"],
        ongoingCount: json["ongoing_count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "ongoing_count": ongoingCount,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.status,
    this.total,
  });

  final String? status;
  final int? total;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        status: json["status"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
      };
}
