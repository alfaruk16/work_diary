class CompleteSlotModel {
  const CompleteSlotModel({required this.id, required this.visitId});

  final int id;
  final int visitId;

  factory CompleteSlotModel.fromJson(Map<String, dynamic> json) =>
      CompleteSlotModel(
        id: json["id"],
        visitId: json["visit_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "visit_id": visitId,
      };
}
