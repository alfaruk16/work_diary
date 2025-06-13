class DistrictId {
  const DistrictId({
    required this.districtId,
  });

  final int districtId;

  factory DistrictId.fromJson(Map<String, dynamic> json) => DistrictId(
        districtId: json["district_id"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
      };
}
