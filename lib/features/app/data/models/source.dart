class Source {
  Source({
    required this.compareValue,
    this.referenceValue,
  });

  final num compareValue;
  final num? referenceValue;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        compareValue: json["compare_value"],
        referenceValue: json["reference_value"],
      );

  Map<String, dynamic> toJson() => {
        "compare_value": compareValue,
        "reference_value": referenceValue,
      };
}
