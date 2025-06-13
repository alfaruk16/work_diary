class Zones {
  const Zones({
    this.data,
  });

  final List<ZoneItem>? data;

  factory Zones.fromJson(Map<String, dynamic> json) => Zones(
        data:
            List<ZoneItem>.from(json["data"].map((x) => ZoneItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ZoneItem {
  const ZoneItem({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory ZoneItem.fromJson(Map<String, dynamic> json) => ZoneItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
