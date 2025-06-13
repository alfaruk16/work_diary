import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class AttendanceResponse {
  const AttendanceResponse({
    this.message,
    this.data,
    this.error,
  });

  final String? message;
  final AttendanceData? data;
  final bool? error;

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceResponse(
        message: json["message"],
        data: AttendanceData.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
        "error": error,
      };
}

class AttendanceData {
  AttendanceData({
    this.visitData,
    this.formList,
  });

  final VisitData? visitData;
  final List<FormList>? formList;

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
        visitData: VisitData.fromJson(json["visitDetails"]),
        formList: List<FormList>.from(
            json["formList"].map((x) => FormList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "visitDetails": visitData!.toJson(),
        "formList": List<dynamic>.from(formList!.map((x) => x.toJson())),
      };
}
