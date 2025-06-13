class DealerCompany {
  const DealerCompany({
    this.data,
  });

  final List<CompanyName>? data;

  factory DealerCompany.fromJson(Map<String, dynamic> json) => DealerCompany(
        data: List<CompanyName>.from(
            json["data"].map((x) => CompanyName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CompanyName {
  CompanyName({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory CompanyName.fromJson(Map<String, dynamic> json) => CompanyName(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
