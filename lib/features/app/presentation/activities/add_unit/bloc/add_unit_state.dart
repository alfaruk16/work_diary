part of 'add_unit_bloc.dart';

class AddUnitState extends Equatable {
  const AddUnitState(
      {this.unitName = '',
      this.unitList = const [],
      this.selectedunitTypeId = -1,
      this.ownerName = '',
      this.mobile = '',
      this.isDealerUnit = false,
      this.isSubDealerUnit = false,
      this.dealerCompanies = const [],
      this.districtList = const [],
      this.upazilas = const [],
      this.dealers = const [],
      this.zoneList = const [],
      this.areaList = const [],
      this.setupazilas = false,
      this.setCompany = false,
      this.resetArea = false,
      this.resetDealer = false,
      this.setCheckBoxState = false,
      this.selectedDistrictId = -1,
      this.selectedUpazilaId = -1,
      this.selectedDealearId = -1,
      this.selectedDealearCompanyId = '',
      this.selectedZoneId = -1,
      this.selectedAreaId = -1,
      this.address = '',
      this.unitsConditionalField = const UnitsConditionalFields(),
      this.forms = Forms.initial,
      this.loading = false,
      this.asRetailer = false,
      this.resetRadioGroup = false,
      this.zoneLoading = false,
      this.areaLoading = false,
      this.unitTypeLoading = false,
      this.districtLoading = false,
      this.subDistrictLoading = false,
      this.dealerLoading = false,
      this.dealerCompanyLoading = false});

  final String unitName;
  final List<DropdownItem> unitList;
  final int selectedunitTypeId;
  final String ownerName;
  final String mobile;
  final bool isDealerUnit;
  final bool isSubDealerUnit;
  final List<DropdownItem> dealerCompanies;
  final List<DropdownItem> districtList;
  final List<DropdownItem> upazilas;
  final List<DropdownItem> dealers;
  final List<DropdownItem> zoneList;
  final List<DropdownItem> areaList;
  final bool setCompany;
  final bool setCheckBoxState;
  final bool setupazilas;
  final bool resetArea;
  final bool resetDealer;
  final int selectedDistrictId;
  final int selectedUpazilaId;
  final int selectedDealearId;
  final String selectedDealearCompanyId;
  final int selectedZoneId;
  final int selectedAreaId;
  final String address;
  final UnitsConditionalFields unitsConditionalField;
  final Forms forms;
  final bool loading;
  final bool asRetailer;
  final bool resetRadioGroup;
  final bool zoneLoading,
      areaLoading,
      unitTypeLoading,
      districtLoading,
      subDistrictLoading,
      dealerLoading,
      dealerCompanyLoading;

  AddUnitState copyWith(
      {String? unitName,
      List<DropdownItem>? unitList,
      int? selectedunitTypeId,
      String? ownerName,
      String? mobile,
      bool? isDealerUnit,
      bool? isSubDealerUnit,
      List<DropdownItem>? dealerCompanies,
      List<DropdownItem>? districtList,
      List<DropdownItem>? upazilas,
      List<DropdownItem>? dealers,
      List<DropdownItem>? zoneList,
      List<DropdownItem>? areaList,
      bool? setupazilas,
      bool? setCompany,
      bool? setCheckBoxState,
      bool? resetArea,
      bool? resetDealer,
      int? selectedDistrictId,
      int? selectedUpazilaId,
      int? selectedDealearId,
      String? selectedDealearCompanyId,
      int? selectedZoneId,
      int? selectedAreaId,
      String? address,
      UnitsConditionalFields? unitsConditionalField,
      Forms? forms,
      bool? loading,
      bool? asRetailer,
      bool? resetRadioGroup,
      bool? zoneLoading,
      bool? areaLoading,
      bool? unitTypeLoading,
      bool? districtLoading,
      bool? subDistrictLoading,
      bool? dealerLoading,
      bool? dealerCompanyLoading}) {
    return AddUnitState(
        unitName: unitName ?? this.unitName,
        unitList: unitList ?? this.unitList,
        selectedunitTypeId: selectedunitTypeId ?? this.selectedunitTypeId,
        ownerName: ownerName ?? this.ownerName,
        mobile: mobile ?? this.mobile,
        isDealerUnit: isDealerUnit ?? this.isDealerUnit,
        isSubDealerUnit: isSubDealerUnit ?? this.isSubDealerUnit,
        dealerCompanies: dealerCompanies ?? this.dealerCompanies,
        districtList: districtList ?? this.districtList,
        upazilas: upazilas ?? this.upazilas,
        dealers: dealers ?? this.dealers,
        zoneList: zoneList ?? this.zoneList,
        areaList: areaList ?? this.areaList,
        setupazilas: setupazilas ?? false,
        setCompany: setCompany ?? false,
        resetArea: resetArea ?? false,
        resetDealer: resetDealer ?? false,
        setCheckBoxState: setCheckBoxState ?? false,
        selectedDistrictId: selectedDistrictId ?? this.selectedDistrictId,
        selectedUpazilaId: selectedUpazilaId ?? this.selectedUpazilaId,
        selectedDealearId: selectedDealearId ?? this.selectedDealearId,
        selectedDealearCompanyId:
            selectedDealearCompanyId ?? this.selectedDealearCompanyId,
        selectedZoneId: selectedZoneId ?? this.selectedZoneId,
        selectedAreaId: selectedAreaId ?? this.selectedAreaId,
        address: address ?? this.address,
        unitsConditionalField:
            unitsConditionalField ?? this.unitsConditionalField,
        forms: forms ?? this.forms,
        loading: loading ?? this.loading,
        asRetailer: asRetailer ?? this.asRetailer,
        resetRadioGroup: resetRadioGroup ?? false,
        zoneLoading: zoneLoading ?? this.zoneLoading,
        areaLoading: areaLoading ?? this.areaLoading,
        unitTypeLoading: unitTypeLoading ?? this.unitTypeLoading,
        districtLoading: districtLoading ?? this.districtLoading,
        subDistrictLoading: subDistrictLoading ?? this.subDistrictLoading,
        dealerLoading: dealerLoading ?? this.dealerLoading,
        dealerCompanyLoading:
            dealerCompanyLoading ?? this.dealerCompanyLoading);
  }

  @override
  List<Object> get props => [
        unitName,
        unitList,
        selectedunitTypeId,
        ownerName,
        mobile,
        isDealerUnit,
        isSubDealerUnit,
        dealerCompanies,
        districtList,
        upazilas,
        dealers,
        zoneList,
        areaList,
        setupazilas,
        setCompany,
        setCheckBoxState,
        resetArea,
        resetDealer,
        selectedDistrictId,
        selectedUpazilaId,
        selectedDealearId,
        selectedDealearCompanyId,
        selectedZoneId,
        selectedAreaId,
        address,
        unitsConditionalField,
        forms,
        loading,
        asRetailer,
        resetRadioGroup,
        zoneLoading,
        areaLoading,
        unitTypeLoading,
        districtLoading,
        subDistrictLoading,
        dealerLoading,
        dealerCompanyLoading
      ];
}

class AddUnitInitial extends AddUnitState {}
