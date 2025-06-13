import 'package:work_diary/features/app/domain/entities/forms_response.dart';

class ChildrenResponse {
  final List<FormData>? data;

  const ChildrenResponse({this.data});

  factory ChildrenResponse.fromJson(Map<String, dynamic> json) =>
      ChildrenResponse(
        data: json["data"] == null
            ? []
            : List<FormData>.from(
                json["data"]!.map((x) => FormData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
