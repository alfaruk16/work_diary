class UnitSave {
  const UnitSave(
      {this.companyId,
      required this.unitTypeId,
      required this.name,
      required this.owner,
      required this.mobile,
      required this.districtId,
      required this.upazilaId,
      required this.address,
      this.asDealer,
      this.dealerId,
      this.asSubDealer,
      this.dealerCompanyId,
      required this.zoneId,
      this.areaId,
      this.asRetailer});

  final int? companyId;
  final int unitTypeId;
  final String name;
  final String owner;
  final String mobile;
  final int districtId;
  final int upazilaId;
  final String address;
  final bool? asDealer;
  final int? dealerId;
  final bool? asSubDealer;
  final String? dealerCompanyId;
  final int zoneId;
  final int? areaId;
  final bool? asRetailer;

  factory UnitSave.fromJson(Map<String, dynamic> json) => UnitSave(
        companyId: json["company_id"],
        unitTypeId: json["unit_type_id"],
        name: json["name"],
        owner: json["owner"],
        mobile: json["mobile"],
        districtId: json["district_id"],
        upazilaId: json["upazila_id"],
        address: json["address"],
        asDealer: json["as_dealer"],
        dealerId: json["dealer_id"],
        asSubDealer: json["as_sub_dealer"],
        asRetailer: json["as_retailer"],
        dealerCompanyId: json["dealer_company_id"],
        zoneId: json["zone_id"],
        areaId: json["area_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "unit_type_id": unitTypeId,
        "name": name,
        "owner": owner,
        "mobile": mobile,
        "district_id": districtId,
        "upazila_id": upazilaId,
        "address": address,
        "as_dealer": asDealer,
        "dealer_id": dealerId,
        "as_sub_dealer": asSubDealer,
        "dealer_company_id": dealerCompanyId,
        "zone_id": zoneId,
        "area_id": areaId,
        "as_retailer": asRetailer,
      };
}
