class Companies {
  const Companies({
    this.data,
    this.unitTypes,
    this.message,
  });

  final List<Company?>? data;
  final Map<String, String?>? unitTypes;
  final String? message;

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
        data: json["data"] == null
            ? []
            : List<Company?>.from(
                json["data"]!.map((x) => Company.fromJson(x))),
        unitTypes: Map.from(json["unit_types"]!)
            .map((k, v) => MapEntry<String, String?>(k, v)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "unit_types":
            Map.from(unitTypes!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "message": message,
      };
}

class Company {
  const Company(
      {this.id,
      this.name,
      this.code,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.areaPlan,
      this.checkingEnabled});

  final int? id;
  final String? name;
  final String? code;
  final String? address;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final bool? areaPlan;
  final bool? checkingEnabled;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        address: json["address"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        areaPlan: json["area_plan"],
        checkingEnabled: json["checkin_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "address": address,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "area_plan": areaPlan,
        "checkin_enabled": checkingEnabled,
      };
}
