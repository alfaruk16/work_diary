class UnitTypesId {
  const UnitTypesId({
    required this.unitTypeId,
  });

  final int unitTypeId;

  factory UnitTypesId.fromJson(Map<String, dynamic> json) => UnitTypesId(
        unitTypeId: json["unit_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "unit_type_id": unitTypeId,
      };
}
