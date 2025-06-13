import 'package:work_diary/features/app/domain/entities/units.dart';

class UnitDetails {
  const UnitDetails({
    this.data,
  });

  final UnitData? data;

  factory UnitDetails.fromJson(Map<String, dynamic> json) => UnitDetails(
        data: UnitData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}
