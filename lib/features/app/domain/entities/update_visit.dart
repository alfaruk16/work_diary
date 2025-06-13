import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class UpdateVisit {
  const UpdateVisit({
    this.message,
    this.error,
    this.data,
  });

  final String? message;
  final bool? error;
  final VisitData? data;

  factory UpdateVisit.fromJson(Map<String, dynamic> json) => UpdateVisit(
        message: json["message"],
        error: json["error"],
        data: VisitData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": data!.toJson(),
      };
}
