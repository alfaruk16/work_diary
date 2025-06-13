class Areas {
  const Areas({
    this.data,
  });

  final List<Area>? data;

  factory Areas.fromJson(Map<String, dynamic> json) => Areas(
        data: List<Area>.from(json["data"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
