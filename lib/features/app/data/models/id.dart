class Id {
  const Id({required this.id});

  final int id;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
