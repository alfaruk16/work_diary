class CheckOutModel {
  final double? lat;
  final double? long;
  final String? address;
  final bool? attendance;

  const CheckOutModel({this.lat, this.long, this.address, this.attendance});

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
        lat: json["lat"],
        long: json["long"],
        address: json["address"],
        attendance: json["attendance"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
        "address": address,
        "attendance": attendance,
      };
}
