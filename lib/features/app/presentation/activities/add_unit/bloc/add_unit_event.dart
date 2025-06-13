part of 'add_unit_bloc.dart';

abstract class AddUnitEvent extends Equatable {
  const AddUnitEvent();

  @override
  List<Object> get props => [];
}

class ChangeUnitName extends AddUnitEvent {
  const ChangeUnitName({required this.unitName});
  final String unitName;
}

class GetUnitType extends AddUnitEvent {}

class UnitTypeSelected extends AddUnitEvent {
  const UnitTypeSelected({required this.unitTypeId});
  final int unitTypeId;
}

class ChangeOwnerName extends AddUnitEvent {
  const ChangeOwnerName({required this.ownerName});
  final String ownerName;
}

class ChangePhone extends AddUnitEvent {
  const ChangePhone({required this.mobile});
  final String mobile;
}

class IsDealer extends AddUnitEvent {
  const IsDealer({required this.isDealer});
  final bool isDealer;
}

class IsSubDealer extends AddUnitEvent {
  const IsSubDealer({required this.isSubDealer});
  final bool isSubDealer;
}

class IsRetailer extends AddUnitEvent {
  const IsRetailer({required this.isRetailer});
  final bool isRetailer;
}

class GetDealerCompanyName extends AddUnitEvent {
  const GetDealerCompanyName({required this.unitTypeId});
  final int unitTypeId;
}

class GetDealerCompanyId extends AddUnitEvent {
  const GetDealerCompanyId({required this.dealerCompanyId});
  final String dealerCompanyId;
}

class GetDistrict extends AddUnitEvent {}

class DistrictSelected extends AddUnitEvent {
  const DistrictSelected({required this.districtId});
  final int districtId;
}

class GetUpazilas extends AddUnitEvent {}

class GetUpazilaId extends AddUnitEvent {
  const GetUpazilaId({required this.upazilaId});
  final int upazilaId;
}

class ChangeAddress extends AddUnitEvent {
  const ChangeAddress({required this.address});
  final String address;
}

class GetDealer extends AddUnitEvent {}

class GetDealerId extends AddUnitEvent {
  const GetDealerId({required this.dealerId});
  final int dealerId;
}

class GetZone extends AddUnitEvent {}

class ZoneSelected extends AddUnitEvent {
  const ZoneSelected({required this.zoneId});
  final int zoneId;
}

class GetAreas extends AddUnitEvent {}

class GetAreaId extends AddUnitEvent {
  const GetAreaId({required this.areaId});
  final int areaId;
}

class MenuItemScreens extends AddUnitEvent {
  const MenuItemScreens({required this.name});
  final String name;
}

class UnitsGetConditionalFields extends AddUnitEvent {}

class PressToContinue extends AddUnitEvent {
  const PressToContinue(
      {required this.unitNameFocusNode,
      required this.ownerNameFocusNode,
      required this.phoneFocusNode,
      required this.addressFocusNode});

  final FocusNode unitNameFocusNode;
  final FocusNode ownerNameFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode addressFocusNode;
}

class CheckZoneIsSelected extends AddUnitEvent{}
