import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';

class FormsResponse {
  const FormsResponse({
    this.data,
    this.meta,
    this.formList,
  });

  final List<FormData?>? data;
  final Meta? meta;
  final FormList? formList;

  factory FormsResponse.fromJson(Map<String, dynamic> json) => FormsResponse(
        data: json["data"] == null
            ? []
            : List<FormData?>.from(
                json["data"]!.map((x) => FormData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        formList: FormList.fromJson(json["form"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "meta": meta!.toJson(),
        "form": formList!.toJson(),
      };
}

class FormData {
  const FormData(
      {this.id,
      this.fieldGroupId,
      this.groupName,
      this.inputFieldName,
      this.name,
      this.displayName,
      this.inputType,
      this.isMultiple,
      this.referenceValue,
      this.compareValue,
      this.isRequired,
      this.isFormula,
      this.isReadonly,
      this.fieldId,
      this.value,
      this.isCumulative,
      this.previousValue,
      this.childrenCount,
      this.parentId});

  final int? id;
  final String? inputFieldName;
  final int? fieldGroupId;
  final String? groupName;
  final String? name;
  final String? displayName;
  final String? inputType;
  final bool? isMultiple;
  final List<ReferenceValue?>? referenceValue;
  final int? compareValue;
  final bool? isRequired;
  final bool? isFormula;
  final bool? isReadonly;
  final dynamic fieldId;
  final String? value;
  final bool? isCumulative;
  final num? previousValue;
  final int? childrenCount;
  final int? parentId;

  factory FormData.fromJson(Map<String, dynamic> json) => FormData(
        id: json["id"],
        inputFieldName: json["input_field_name"],
        fieldGroupId: json["field_group_id"],
        groupName: json["group_name"],
        name: json["name"],
        displayName: json["display_name"],
        inputType: json["input_type"],
        isMultiple: json["is_multiple"],
        referenceValue: json["reference_value"] == null
            ? []
            : List<ReferenceValue?>.from(json["reference_value"]!
                .map((x) => ReferenceValue.fromJson(x))),
        compareValue: json["compare_value"],
        isRequired: json["is_required"],
        isFormula: json["is_formula"],
        isReadonly: json["is_readonly"],
        fieldId: json["field_id"],
        value: json["value"],
        isCumulative: json["is_cumulative"],
        previousValue: json["previous_value"],
        childrenCount: json["children_count"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "input_field_name": inputFieldName,
        "field_group_id": fieldGroupId,
        "group_name": groupName,
        "name": name,
        "display_name": displayName,
        "input_type": inputType,
        "is_multiple": isMultiple,
        "reference_value": referenceValue == null
            ? []
            : List<dynamic>.from(referenceValue!.map((x) => x!.toJson())),
        "compare_value": compareValue,
        "is_required": isRequired,
        "is_formula": isFormula,
        "is_readonly": isReadonly,
        "field_id": fieldId,
        "value": value,
        "is_cumulative": isCumulative,
        "previous_value": previousValue,
        "children_count": childrenCount,
        "parent_id": parentId,
      };
}

enum InputType { number, text, date, dropdown, image, hidden }

final inputTypeValues = EnumValues({
  "date": InputType.date,
  "dropdown": InputType.dropdown,
  "number": InputType.number,
  "text": InputType.text,
  "image": InputType.image,
  "hidden": InputType.hidden,
});

class ReferenceValue {
  ReferenceValue({
    this.type,
    this.value,
  });

  String? type;
  String? value;

  factory ReferenceValue.fromJson(Map<String, dynamic> json) => ReferenceValue(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}