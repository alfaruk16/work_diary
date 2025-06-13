import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class EmergencyTaskDetails {
  const EmergencyTaskDetails({
    this.data,
  });

  final TaskDtls? data;

  factory EmergencyTaskDetails.fromJson(Map<String, dynamic> json) =>
      EmergencyTaskDetails(
        data: TaskDtls.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class TaskDtls {
  TaskDtls({
    this.id,
    this.name,
    this.status,
    this.unitType,
    this.unitId,
    this.unitName,
    this.companyName,
    this.createdBy,
    this.supervisor,
    this.assaignTo,
    this.dateFor,
    this.created,
    this.updated,
    this.completedAt,
    this.completedTime,
    this.canComplete,
    this.btns,
    this.forOwn,
    this.comments,
    this.taskNote,
    this.visitImages,
  });

  final int? id;
  final String? name;
  final String? status;
  final String? unitType;
  final int? unitId;
  final String? unitName;
  final String? companyName;
  final String? createdBy;
  final String? supervisor;
  final String? assaignTo;
  final String? dateFor;
  final String? created;
  final String? updated;
  final String? completedAt;
  final String? completedTime;
  final bool? canComplete;
  final List<Btn?>? btns;
  final bool? forOwn;
  final String? comments;
  final String? taskNote;
  final List<VisitImage>? visitImages;

  factory TaskDtls.fromJson(Map<String, dynamic> json) => TaskDtls(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        unitType: json["unit_type"],
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        companyName: json["company_name"],
        createdBy: json["created_by"],
        supervisor: json["supervisor"],
        assaignTo: json["assaign_to"],
        dateFor: json["date_for"],
        created: json["created"],
        updated: json["updated"],
        completedAt: json["completed_at"],
        completedTime: json["completed_time"],
        canComplete: json["can_complete"],
        btns: json["btns"] == null
            ? []
            : List<Btn?>.from(json["btns"]!.map((x) => Btn.fromJson(x))),
        forOwn: json["for_own"],
        comments: json["comments"],
        taskNote: json["task_note"],
        visitImages: List<VisitImage>.from(
            json["visit_images"].map((x) => VisitImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "unit_type": unitType,
        "unit_id": unitId,
        "unit_name": unitName,
        "company_name": companyName,
        "created_by": createdBy,
        "supervisor": supervisor,
        "assaign_to": assaignTo,
        "date_for": dateFor,
        "created": created,
        "updated": updated,
        "completed_at": completedAt,
        "completed_time": completedTime,
        "can_complete": canComplete,
        "btns": btns == null
            ? []
            : List<dynamic>.from(btns!.map((x) => x!.toJson())),
        "for_own": forOwn,
        "comments": comments,
        "task_note": taskNote,
        "visit_images": List<dynamic>.from(visitImages!.map((x) => x.toJson())),
      };
}
