class ZoneId {
  const ZoneId({
    required this.zoneId,
  });

  final int zoneId;

  factory ZoneId.fromJson(Map<String, dynamic> json) => ZoneId(
        zoneId: json["zone_id"],
      );

  Map<String, dynamic> toJson() => {
        "zone_id": zoneId,
      };
}
