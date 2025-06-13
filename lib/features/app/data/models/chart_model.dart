class ChartModel {
  const ChartModel({
    this.chartFor,
    this.visitorId,
  });

  final String? chartFor;
  final int? visitorId;

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        chartFor: json["chart_for"],
        visitorId: json["visitor_id"],
      );

  Map<String, dynamic> toJson() => {
        "chart_for": chartFor,
        "visitor_id": visitorId,
      };
}
