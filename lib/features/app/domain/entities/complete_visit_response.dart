class CompleteVisitResponse {
  const CompleteVisitResponse({
    this.visitData,
    this.formList,
  });

  final VisitData? visitData;
  final List<FormList?>? formList;

  factory CompleteVisitResponse.fromJson(Map<String, dynamic> json) =>
      CompleteVisitResponse(
        visitData: VisitData.fromJson(json["visitDetails"]),
        formList: json["formList"] == null
            ? []
            : List<FormList?>.from(
                json["formList"]!.map((x) => FormList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "visitData": visitData!.toJson(),
        "formList": formList == null
            ? []
            : List<dynamic>.from(formList!.map((x) => x!.toJson())),
      };
}

class FormList {
  FormList({
    this.id,
    this.name,
    this.isMultiple,
    this.nameForMultiple,
    this.timeDurationUnit,
    this.visitId,
    this.visitFor,
    this.visitStatus,
    this.canAdd,
    this.canEdit,
    this.canDelete,
    this.canAddMore,
    this.visitForms,
  });

  final int? id;
  final String? name;
  final bool? isMultiple;
  final String? nameForMultiple;
  final String? timeDurationUnit;
  final int? visitId;
  final String? visitFor;
  final String? visitStatus;
  final bool? canAdd;
  final bool? canEdit;
  final bool? canDelete;
  final bool? canAddMore;
  List<VisitForm?>? visitForms;

  factory FormList.fromJson(Map<String, dynamic> json) => FormList(
        id: json["id"],
        name: json["name"],
        isMultiple: json["is_multiple"],
        nameForMultiple: json["name_for_multiple"],
        timeDurationUnit: json["time_duration_unit"],
        visitId: json["visit_id"],
        visitFor: json["visit_for"],
        visitStatus: json["visit_status"],
        canAdd: json["can_add"],
        canEdit: json["can_edit"],
        canDelete: json["can_delete"],
        canAddMore: json["can_add_more"],
        visitForms: json["visit_forms"] == null
            ? []
            : List<VisitForm?>.from(
                json["visit_forms"]!.map((x) => VisitForm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_multiple": isMultiple,
        "name_for_multiple": nameForMultiple,
        "time_duration_unit": timeDurationUnit,
        "visit_id": visitId,
        "visit_for": visitFor,
        "visit_status": visitStatus,
        "can_add": canAdd,
        "can_edit": canEdit,
        "can_delete": canDelete,
        "can_add_more": canAddMore,
        "visit_forms": visitForms == null
            ? []
            : List<dynamic>.from(visitForms!.map((x) => x!.toJson())),
      };
}

class VisitForm {
  VisitForm({
    this.visitFormId,
    this.visitFormDetails,
  });

  final int? visitFormId;
  final List<VisitFormDetail?>? visitFormDetails;

  factory VisitForm.fromJson(Map<String, dynamic> json) => VisitForm(
        visitFormId: json["visit_form_id"],
        visitFormDetails: json["visit_form_details"] == null
            ? []
            : List<VisitFormDetail?>.from(json["visit_form_details"]!
                .map((x) => VisitFormDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "visit_form_id": visitFormId,
        "visit_form_details": visitFormDetails == null
            ? []
            : List<dynamic>.from(visitFormDetails!.map((x) => x!.toJson())),
      };
}

class VisitFormDetail {
  VisitFormDetail({
    this.id,
    this.value,
    this.inputType,
    this.groupId,
    this.groupName,
    this.field,
  });

  final int? id;
  final String? value;
  final String? inputType;
  final int? groupId;
  final String? groupName;
  final Field? field;

  factory VisitFormDetail.fromJson(Map<String, dynamic> json) =>
      VisitFormDetail(
        id: json["id"],
        value: json["value"],
        inputType: json["input_type"],
        groupId: json["group_id"],
        groupName: json["group_name"],
        field: Field.fromJson(json["field"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "input_type": inputType,
        "group_id": groupId,
        "group_name": groupName,
        "field": field!.toJson(),
      };
}

class Field {
  Field({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class VisitData {
  const VisitData(
      {this.id,
      this.name,
      this.visitNote,
      this.status,
      this.unitType,
      this.isSlotEnabled,
      this.companyUnitId,
      this.unitId,
      this.unitName,
      this.unitCode,
      this.unitAddress,
      this.unitZoneArea,
      this.companyName,
      this.createdBy,
      this.supervisor,
      this.assaignTo,
      this.assaigneeId,
      this.dateFor,
      this.created,
      this.updated,
      this.startedAt,
      this.startedTime,
      this.completedAt,
      this.completedTime,
      this.hasAttendance,
      this.forOwn,
      this.canStart,
      this.canComplete,
      this.btns,
      this.canEdit,
      this.comments,
      this.visitImages,
      this.slot,
      this.isExtended,
      this.isUpcoming});

  final int? id;
  final String? name;
  final String? visitNote;
  final String? status;
  final String? unitType;
  final bool? isSlotEnabled;
  final int? companyUnitId;
  final int? unitId;
  final String? unitName;
  final String? unitCode;
  final String? unitAddress;
  final String? unitZoneArea;
  final String? companyName;
  final String? createdBy;
  final String? supervisor;
  final String? assaignTo;
  final int? assaigneeId;
  final String? dateFor;
  final String? created;
  final String? updated;
  final String? startedAt;
  final String? startedTime;
  final dynamic completedAt;
  final dynamic completedTime;
  final bool? hasAttendance;
  final bool? forOwn;
  final bool? canStart;
  final bool? canComplete;
  final List<Btn?>? btns;
  final bool? canEdit;
  final String? comments;
  final List<VisitImage?>? visitImages;
  final Slot? slot;
  final bool? isExtended;
  final bool? isUpcoming;

  factory VisitData.fromJson(Map<String, dynamic> json) => VisitData(
        id: json["id"],
        name: json["name"],
        visitNote: json["visit_note"],
        status: json["status"],
        unitType: json["unit_type"],
        isSlotEnabled: json["is_slot_enabled"],
        companyUnitId: json["company_unit_id"],
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        unitCode: json["unit_code"],
        unitAddress: json["unit_address"],
        unitZoneArea: json["unit_zone_area"],
        companyName: json["company_name"],
        createdBy: json["created_by"],
        supervisor: json["supervisor"],
        assaignTo: json["assaign_to"],
        assaigneeId: json["assaignee_id"],
        dateFor: json["date_for"],
        created: json["created"],
        updated: json["updated"],
        startedAt: json["started_at"],
        startedTime: json["started_time"],
        completedAt: json["completed_at"],
        completedTime: json["completed_time"],
        hasAttendance: json["has_attendance"],
        forOwn: json["for_own"],
        canStart: json["can_start"],
        canComplete: json["can_complete"],
        btns: json["btns"] == null
            ? []
            : List<Btn?>.from(json["btns"]!.map((x) => Btn.fromJson(x))),
        canEdit: json["can_edit"],
        comments: json["comments"],
        visitImages: json["visit_images"] == null
            ? []
            : List<VisitImage?>.from(
                json["visit_images"]!.map((x) => VisitImage.fromJson(x))),
        slot: json["slot"] == null ? null : Slot.fromJson(json["slot"]),
        isExtended: json["is_extended"],
        isUpcoming: json["is_upcoming"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "visit_note": visitNote,
        "status": status,
        "unit_type": unitType,
        "is_slot_enabled": isSlotEnabled,
        "company_unit_id": companyUnitId,
        "unit_id": unitId,
        "unit_name": unitName,
        "unit_code": unitCode,
        "unit_address": unitAddress,
        "unit_zone_area": unitZoneArea,
        "company_name": companyName,
        "created_by": createdBy,
        "supervisor": supervisor,
        "assaign_to": assaignTo,
        "assaignee_id": assaigneeId,
        "date_for": dateFor,
        "created": created,
        "updated": updated,
        "started_at": startedAt,
        "started_time": startedTime,
        "completed_at": completedAt,
        "completed_time": completedTime,
        "has_attendance": hasAttendance,
        "for_own": forOwn,
        "can_start": canStart,
        "can_complete": canComplete,
        "btns": btns == null
            ? []
            : List<dynamic>.from(btns!.map((x) => x!.toJson())),
        "can_edit": canEdit,
        "comments": comments,
        "visit_images": visitImages == null
            ? []
            : List<dynamic>.from(visitImages!.map((x) => x!.toJson())),
        "slot": slot == null ? null : slot!.toJson(),
        "is_extended": isExtended,
        "is_upcoming": isUpcoming
      };
}

class VisitImage {
  VisitImage({
    this.id,
    this.img,
  });

  final int? id;
  final String? img;

  factory VisitImage.fromJson(Map<String, dynamic> json) => VisitImage(
        id: json["id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
      };
}

class Btn {
  Btn({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory Btn.fromJson(Map<String, dynamic> json) => Btn(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class Slot {
  Slot({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.slotDetails,
  });

  final int? id;
  final String? name;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final List<SlotDetail>? slotDetails;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        name: json["name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        createdAt: json["created_at"],
        slotDetails: List<SlotDetail>.from(
            json["slot_details"].map((x) => SlotDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
        "created_at": createdAt,
        "slot_details": List<dynamic>.from(slotDetails!.map((x) => x.toJson())),
      };
}

class SlotDetail {
  SlotDetail({
    this.slotFieldId,
    this.name,
    this.value,
  });

  final int? slotFieldId;
  final String? name;
  final String? value;

  factory SlotDetail.fromJson(Map<String, dynamic> json) => SlotDetail(
        slotFieldId: json["slot_field_id"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "slot_field_id": slotFieldId,
        "name": name,
        "value": value,
      };
}
