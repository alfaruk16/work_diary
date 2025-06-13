class UnitsConditionalFields {
  const UnitsConditionalFields({
    this.canTagAsDealer,
    this.canTagAsSubDealer,
    this.canSetDealerCompanyName,
    this.canSetUnitUnderDealer,
  });

  final bool? canTagAsDealer;
  final bool? canTagAsSubDealer;
  final bool? canSetDealerCompanyName;
  final bool? canSetUnitUnderDealer;

  factory UnitsConditionalFields.fromJson(Map<String, dynamic> json) =>
      UnitsConditionalFields(
        canTagAsDealer: json["can_tag_as_dealer"],
        canTagAsSubDealer: json["can_tag_as_sub_dealer"],
        canSetDealerCompanyName: json["can_set_dealer_company_name"],
        canSetUnitUnderDealer: json["can_set_unit_under_dealer"],
      );

  Map<String, dynamic> toJson() => {
        "can_tag_as_dealer": canTagAsDealer,
        "can_tag_as_sub_dealer": canTagAsSubDealer,
        "can_set_dealer_company_name": canSetDealerCompanyName,
        "can_set_unit_under_dealer": canSetUnitUnderDealer,
      };
}
