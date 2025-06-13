class DistrictList {
  const DistrictList({
    this.data,
  });

  final List<District>? data;

  factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
        data:
            List<District>.from(json["data"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
