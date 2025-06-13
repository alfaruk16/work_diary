import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class Visits {
  const Visits({
    this.data,
  });

  final List<VisitData>? data;

  factory Visits.fromJson(Map<String, dynamic> json) => Visits(
        data: List<VisitData>.from(
            json["data"].map((x) => VisitData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
