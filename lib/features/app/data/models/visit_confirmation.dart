class VisitConfirmation {
  const VisitConfirmation({
    required this.id,
    this.comments,
    this.lat,
    this.long,
    this.address,
    this.confirmBtn,
  });

  final int id;
  final String? comments;
  final String? lat;
  final String? long;
  final String? address;
  final bool? confirmBtn;

  factory VisitConfirmation.fromJson(Map<String, dynamic> json) =>
      VisitConfirmation(
        id: json["id"],
        comments: json["comments"],
        lat: json["lat"],
        long: json["long"],
        address: json["address"],
        confirmBtn: json["confirmBtn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comments": comments,
        "lat": lat,
        "long": long,
        "address": address,
        "confirmBtn": confirmBtn,
      };
}
