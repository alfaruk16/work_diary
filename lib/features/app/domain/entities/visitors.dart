class Visitors {
  const Visitors({
    this.data,
  });

  final List<Visitor>? data;

  factory Visitors.fromJson(Map<String, dynamic> json) => Visitors(
        data: List<Visitor>.from(json["data"].map((x) => Visitor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Visitor {
  Visitor({
    this.id,
    this.code,
    this.role,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
    this.designation,
    this.department,
    this.company,
  });

  final int? id;
  final String? code;
  final String? role;
  final String? name;
  final String? email;
  final String? mobile;
  final String? avatar;
  final String? designation;
  final String? department;
  final String? company;

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        id: json["id"],
        code: json["code"],
        role: json["role"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        designation: json["designation"],
        department: json["department"],
        company: json["company"],
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
        "company": company,
      };
}
