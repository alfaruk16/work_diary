class UnitTypes {
  const UnitTypes({
    this.data,
  });

  final List<UnitType>? data;

  factory UnitTypes.fromJson(Map<String, dynamic> json) => UnitTypes(
        data:
            List<UnitType>.from(json["data"].map((x) => UnitType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UnitType {
  const UnitType({
    this.id,
    this.name,
    this.isSlotEnabled,
  });

  final int? id;
  final String? name;
  final bool? isSlotEnabled;

  factory UnitType.fromJson(Map<String, dynamic> json) => UnitType(
        id: json["id"],
        name: json["name"],
        isSlotEnabled: json["is_slot_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_slot_enabled": isSlotEnabled,
      };
}
