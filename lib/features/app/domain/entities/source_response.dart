class SourceResponse {
  const SourceResponse({
    this.data,
  });

  final List<SourceData>? data;

  factory SourceResponse.fromJson(Map<String, dynamic> json) => SourceResponse(
        data: List<SourceData>.from(json["data"].map((x) => SourceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SourceData {
  SourceData({
    this.id,
    this.value,
  });

  final int? id;
  final String? value;

  factory SourceData.fromJson(Map<String, dynamic> json) => SourceData(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}

class SourceObject {
  const SourceObject({
    this.data,
  });

  final SourceData? data;

  factory SourceObject.fromJson(Map<String, dynamic> json) => SourceObject(
        data: SourceData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}
