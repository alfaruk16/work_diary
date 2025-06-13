class ToDoList {
  const ToDoList({
    this.visits,
  });

  final List<ToDoVisit>? visits;

  factory ToDoList.fromJson(Map<String, dynamic> json) => ToDoList(
        visits: List<ToDoVisit>.from(
            json["todoVisits"].map((x) => ToDoVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "visits": List<dynamic>.from(visits!.map((x) => x.toJson())),
      };
}

class ToDoVisit {
  ToDoVisit({
    required this.id,
    required this.status,
    required this.dateFor,
  });

  int id;
  String status;
  String dateFor;

  factory ToDoVisit.fromJson(Map<String, dynamic> json) => ToDoVisit(
        id: json["id"],
        status: json["status"],
        dateFor: json["date_for"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "date_for": dateFor,
      };
}
