import 'package:work_diary/features/app/domain/entities/forms_response.dart';

class SlotResponse {
  const SlotResponse({
    this.data,
  });

  final List<FormData>? data;

  factory SlotResponse.fromJson(Map<String, dynamic> json) => SlotResponse(
        data:
            List<FormData>.from(json["data"].map((x) => FormData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
