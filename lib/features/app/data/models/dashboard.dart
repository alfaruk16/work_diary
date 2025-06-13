class Dashboard {
  const Dashboard({
    required this.dashboardFor,
  });

  final String? dashboardFor;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        dashboardFor: json["dashboard_for"],
      );

  Map<String, dynamic> toJson() => {
        "dashboard_for": dashboardFor,
      };
}
