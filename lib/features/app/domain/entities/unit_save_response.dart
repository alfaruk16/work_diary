import 'package:work_diary/features/app/domain/entities/units.dart';

class UnitSaveResponse {
  const UnitSaveResponse({
    this.message,
    this.errors,
    this.data,
  });

  final String? message;
  final bool? errors;
  final UnitData? data;

  factory UnitSaveResponse.fromJson(Map<String, dynamic> json) =>
      UnitSaveResponse(
        message: json["message"],
        errors: json["errors"],
        data: UnitData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors,
        "data": data!.toJson(),
      };
}

