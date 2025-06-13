class Upazilas {
  const Upazilas({
    this.data,
  });

  final List<Upazila>? data;

  factory Upazilas.fromJson(Map<String, dynamic> json) => Upazilas(
        data: List<Upazila>.from(json["data"].map((x) => Upazila.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Upazila {
  Upazila({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Upazila.fromJson(Map<String, dynamic> json) => Upazila(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
