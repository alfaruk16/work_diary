class VisitStatus {
  const VisitStatus({
    this.data,
  });

  final List<Status>? data;

  factory VisitStatus.fromJson(Map<String, dynamic> json) => VisitStatus(
        data: List<Status>.from(json["data"].map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Status {
  const Status({
    this.name,
    this.value,
  });

  final String? name;
  final String? value;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
