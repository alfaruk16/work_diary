class VisitObjectives {
  const VisitObjectives({
    this.data,
  });

  final List<Obective>? data;

  factory VisitObjectives.fromJson(Map<String, dynamic> json) =>
      VisitObjectives(
        data:
            List<Obective>.from(json["data"].map((x) => Obective.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Obective {
  const Obective({
    this.title,
  });

  final String? title;

  factory Obective.fromJson(Map<String, dynamic> json) => Obective(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
