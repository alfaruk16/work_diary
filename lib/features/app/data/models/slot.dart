class SlotModel {
  const SlotModel({
    required this.visitId,
  });

  final int visitId;

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
        visitId: json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "visit_id": visitId,
      };
}
