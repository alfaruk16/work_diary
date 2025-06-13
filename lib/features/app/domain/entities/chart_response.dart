class ChartResponse {
  const ChartResponse({
    this.charts,
  });

  final Charts? charts;

  factory ChartResponse.fromJson(Map<String, dynamic> json) => ChartResponse(
        charts: Charts.fromJson(json["charts"]),
      );

  Map<String, dynamic> toJson() => {
        "charts": charts!.toJson(),
      };
}

class Charts {
  Charts({
    this.interval,
    this.maxvalue,
    this.label,
    this.data,
  });

  final int? interval;
  final int? maxvalue;
  final Label? label;
  final List<BarData>? data;

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
        interval: json["interval"],
        maxvalue: json["maxvalue"],
        label: Label.fromJson(json["label"]),
        data: List<BarData>.from(json["data"].map((x) => BarData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "interval": interval,
        "maxvalue": maxvalue,
        "label": label!.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BarData {
  BarData({
    this.week,
    this.total,
    this.completed,
  });

  final String? week;
  final int? total;
  final int? completed;

  factory BarData.fromJson(Map<String, dynamic> json) => BarData(
        week: json["week"],
        total: json["total"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "week": week,
        "total": total,
        "completed": completed,
      };
}

class Label {
  Label({
    this.total,
    this.completed,
  });

  final String? total;
  final String? completed;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        total: json["total"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "completed": completed,
      };
}
