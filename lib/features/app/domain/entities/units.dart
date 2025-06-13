import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';

class UnitResponse {
  final List<UnitData>? data;
  final Meta? meta;

  const UnitResponse({
    this.data,
    this.meta,
  });

  factory UnitResponse.fromJson(Map<String, dynamic> json) => UnitResponse(
        data: json["data"] == null
            ? []
            : List<UnitData>.from(
                json["data"]!.map((x) => UnitData.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class UnitData {
  final int? id;
  final int? companyUnitId;
  final String? name;
  final String? code;
  final String? mobile;
  final String? owner;
  final bool? asDealer;
  final bool? asSubDealer;
  final int? unitTypeId;
  final String? unitType;
  final String? company;
  final String? address;
  final String? location;
  final String? status;
  final String? created;
  final String? createdBy;
  final String? visitCount;

  UnitData(
      {this.id,
      this.companyUnitId,
      this.name,
      this.code,
      this.mobile,
      this.owner,
      this.asDealer,
      this.asSubDealer,
      this.unitTypeId,
      this.unitType,
      this.company,
      this.address,
      this.location,
      this.status,
      this.created,
      this.createdBy,
      this.visitCount});

  factory UnitData.fromJson(Map<String, dynamic> json) => UnitData(
        id: json["id"],
        companyUnitId: json["company_unit_id"],
        name: json["name"],
        code: json["code"],
        mobile: json["mobile"],
        owner: json["owner"],
        asDealer: json["as_dealer"],
        asSubDealer: json["as_sub_dealer"],
        unitTypeId: json["unit_type_id"],
        unitType: json["unit_type"],
        company: json["company"],
        address: json["address"],
        location: json["location"],
        status: json["status"],
        created: json["created"],
        createdBy: json["created_by"],
        visitCount: json["visits_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_unit_id": companyUnitId,
        "name": name,
        "code": code,
        "mobile": mobile,
        "owner": owner,
        "as_dealer": asDealer,
        "as_sub_dealer": asSubDealer,
        "unit_type_id": unitTypeId,
        "unit_type": unitType,
        "company": company,
        "address": address,
        "location": location,
        "status": status,
        "created": created,
        "created_by": createdBy,
        "visits_count": visitCount,
      };
}

// class Meta {
//   final int? currentPage;
//   final int? from;
//   final int? lastPage;
//   final String? path;
//   final int? perPage;
//   final int? to;
//   final int? total;
//
//   Meta({
//     this.currentPage,
//     this.from,
//     this.lastPage,
//     this.path,
//     this.perPage,
//     this.to,
//     this.total,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         currentPage: json["current_page"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         path: json["path"],
//         perPage: json["per_page"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "from": from,
//         "last_page": lastPage,
//         "path": path,
//         "per_page": perPage,
//         "to": to,
//         "total": total,
//       };
// }
