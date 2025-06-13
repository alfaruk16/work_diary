class PerformanceReport {
  final Data? data;

  const PerformanceReport({
    this.data,
  });

  factory PerformanceReport.fromJson(Map<String, dynamic> json) => PerformanceReport(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  final String? status;
  final double? performance;
  final int? targetTotal;
  final int? actualTotal;
  final List<Detail>? details;

  Data({
    this.status,
    this.performance,
    this.targetTotal,
    this.actualTotal,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    performance: json["performance"]?.toDouble(),
    targetTotal: json["target_total"],
    actualTotal: json["actual_total"],
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "performance": performance,
    "target_total": targetTotal,
    "actual_total": actualTotal,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  final String? unitTypeName;
  final int? formFieldId;
  final int? targetOwn;
  final int? actualOwn;
  final int? targetCompetitor;
  final int? actualCompetitor;
  final int? targetTotal;
  final int? actualTotal;

  Detail({
    this.unitTypeName,
    this.formFieldId,
    this.targetOwn,
    this.actualOwn,
    this.targetCompetitor,
    this.actualCompetitor,
    this.targetTotal,
    this.actualTotal,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    unitTypeName: json["unit_type_name"],
    formFieldId: json["form_field_id"],
    targetOwn: json["target_own"],
    actualOwn: json["actual_own"],
    targetCompetitor: json["target_competitor"],
    actualCompetitor: json["actual_competitor"],
    targetTotal: json["target_total"],
    actualTotal: json["actual_total"],
  );

  Map<String, dynamic> toJson() => {
    "unit_type_name": unitTypeName,
    "form_field_id": formFieldId,
    "target_own": targetOwn,
    "actual_own": actualOwn,
    "target_competitor": targetCompetitor,
    "actual_competitor": actualCompetitor,
    "target_total": targetTotal,
    "actual_total": actualTotal,
  };
}
