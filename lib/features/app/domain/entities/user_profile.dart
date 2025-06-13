import 'package:work_diary/features/app/domain/entities/companies.dart';
import 'package:work_diary/features/app/domain/entities/visitors.dart';

class UserDetails {
  const UserDetails({this.data});

  final UserData? data;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class UserData {
  const UserData(
      {this.id,
      this.code,
      this.role,
      this.name,
      this.email,
      this.mobile,
      this.avatar,
      this.designation,
      this.department,
      this.company,
      this.supervisor,
      this.visitors,
      this.isSupervisor,
      this.created,
      this.updated,
      this.isCheckedIn,
      this.lastCheckedIn});

  final int? id;
  final String? code;
  final String? role;
  final String? name;
  final String? email;
  final String? mobile;
  final String? avatar;
  final String? designation;
  final String? department;
  final Company? company;
  final dynamic supervisor;
  final List<Visitor?>? visitors;
  final bool? isSupervisor;
  final String? created;
  final String? updated;
  final bool? isCheckedIn;
  final String? lastCheckedIn;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        code: json["code"],
        role: json["role"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        designation: json["designation"],
        department: json["department"],
        company: Company.fromJson(json["company"]),
        supervisor: json["supervisor"],
        visitors: json["visitors"] == null
            ? []
            : List<Visitor?>.from(
                json["visitors"]!.map((x) => Visitor.fromJson(x))),
        isSupervisor: json["is_supervisor"],
        created: json["created"],
        updated: json["updated"],
        isCheckedIn: json["is_checkedin"],
        lastCheckedIn: json["last_checkedin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "role": role,
        "name": name,
        "email": email,
        "mobile": mobile,
        "avatar": avatar,
        "designation": designation,
        "department": department,
        "company": company!.toJson(),
        "supervisor": supervisor,
        "visitors": visitors == null
            ? []
            : List<dynamic>.from(visitors!.map((x) => x!.toJson())),
        "is_supervisor": isSupervisor,
        "created": created,
        "updated": updated,
        "is_checkedin": isCheckedIn,
        "last_checkedin": lastCheckedIn
      };
}
