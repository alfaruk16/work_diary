class PlanListResponse {
  final List<Datum>? data;

  const PlanListResponse({
    this.data,
  });

  factory PlanListResponse.fromJson(Map<String, dynamic> json) =>
      PlanListResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final String? name;
  final String? dateFor;
  final int? visitsCount;

  Datum({this.id, this.name, this.dateFor, this.visitsCount});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        dateFor: json["date_for"],
        visitsCount: json["visits_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_for": dateFor,
        "visits_count": visitsCount
      };
}
