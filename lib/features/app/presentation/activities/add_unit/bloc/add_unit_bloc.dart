import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/form_validator/validator.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/company_id.dart';
import 'package:work_diary/features/app/data/models/dealer_units.dart';
import 'package:work_diary/features/app/data/models/district_id.dart';
import 'package:work_diary/features/app/data/models/unit_save.dart';
import 'package:work_diary/features/app/data/models/unit_type_id.dart';
import 'package:work_diary/features/app/data/models/zone_id.dart';
import 'package:work_diary/features/app/domain/entities/areas.dart';
import 'package:work_diary/features/app/domain/entities/dealer_company.dart';
import 'package:work_diary/features/app/domain/entities/district.dart';
import 'package:work_diary/features/app/domain/entities/unit_save_response.dart';
import 'package:work_diary/features/app/domain/entities/unit_type.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/entities/units_get_conditional_fields.dart';
import 'package:work_diary/features/app/domain/entities/upazilas.dart';
import 'package:work_diary/features/app/domain/entities/zone.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/view/dashboard_screen.dart';
import 'package:work_diary/features/app/presentation/activities/unit_list/view/unit_list_screen.dart';

part 'add_unit_event.dart';
part 'add_unit_state.dart';

class AddUnitBloc extends Bloc<AddUnitEvent, AddUnitState> {
  AddUnitBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(AddUnitInitial()) {
    on<ChangeUnitName>(_changeUnitName);
    on<GetUnitType>(_getUnitType);
    on<UnitTypeSelected>(_unitTypeSelected);
    on<ChangeOwnerName>(_changeOwnerName);
    on<ChangePhone>(_changePhone);
    on<IsDealer>(_isDealer);
    on<IsSubDealer>(_isSubDealer);
    on<GetDealerCompanyName>(_getDealerCompanyName);
    on<GetDealerCompanyId>(_getDealerCompanyId);
    on<GetDealer>(_getDealer);
    on<GetDealerId>(_getDealerId);
    on<GetDistrict>(_getDistrict);
    on<DistrictSelected>(_districtSelected);
    on<GetUpazilas>(_getUpazilas);
    on<GetUpazilaId>(_getUpazilaId);
    on<ChangeAddress>(_changeAddress);
    on<GetZone>(_getZone);
    on<ZoneSelected>(_zoneSelected);
    on<GetAreas>(_getAreas);
    on<GetAreaId>(_getAreaId);
    on<MenuItemScreens>(_menuItemScreens);
    on<UnitsGetConditionalFields>(_unitsGetConditionalFields);
    on<PressToContinue>(_pressToContinue);
    on<IsRetailer>(_isRetailer);
    on<CheckZoneIsSelected>(_checkZoneIsSelected);

    add(GetUnitType());
    add(GetDistrict());
    add(GetZone());
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _changeUnitName(
      ChangeUnitName event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(unitName: event.unitName));
  }

//Get Unit type
  FutureOr<void> _getUnitType(
      GetUnitType event, Emitter<AddUnitState> emit) async {
    emit(state.copyWith(unitTypeLoading: true));
    final unitTypeResponse = await _apiRepo.post(
      endpoint: unitsGetParentTypesEndpoint,
      responseModel: const UnitTypes(),
    );
    emit(state.copyWith(unitTypeLoading: false));
    if (unitTypeResponse != null) {
      final matchDropdown = <DropdownItem>[];
      for (int i = 0; i < unitTypeResponse.data!.length; i++) {
        matchDropdown.add(DropdownItem(
            name: unitTypeResponse.data![i].name!,
            value: unitTypeResponse.data![i].id!));
      }
      emit(state.copyWith(unitList: matchDropdown));
    }
  }

  FutureOr<void> _unitTypeSelected(
      UnitTypeSelected event, Emitter<AddUnitState> emit) {
    if (event.unitTypeId != state.selectedunitTypeId) {
      final companies = <DropdownItem>[];
      emit(state.copyWith(
          selectedunitTypeId: event.unitTypeId,
          setCompany: true,
          selectedDealearCompanyId: '',
          dealerCompanies: companies));
      if (state.selectedunitTypeId != -1) {
        emit(state.copyWith(
          isDealerUnit: false,
          setCheckBoxState: true,
          selectedDealearId: -1,
          isSubDealerUnit: false,
        ));
        add(UnitsGetConditionalFields());
      }
    }
  }

  //Get Dealer Company by ID
  FutureOr<void> _getDealerCompanyName(
      GetDealerCompanyName event, Emitter<AddUnitState> emit) async {
    emit(state.copyWith(dealerCompanyLoading: true));
    final company = await _apiRepo.post(
        endpoint: dealerCompaniesGetEndpoint,
        body: UnitTypesId(unitTypeId: event.unitTypeId),
        responseModel: const DealerCompany());
    emit(state.copyWith(dealerCompanyLoading: false));
    if (company != null) {
      final items = <DropdownItem>[];
      for (int i = 0; i < company.data!.length; i++) {
        items.add(DropdownItem(
          name: company.data![i].name!,
          value: company.data![i].id!,
        ));
      }
      emit(state.copyWith(dealerCompanies: items));
    }
  }

  FutureOr<void> _getDealerCompanyId(
      GetDealerCompanyId event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(selectedDealearCompanyId: event.dealerCompanyId));
  }

  FutureOr<void> _changeOwnerName(
      ChangeOwnerName event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(ownerName: event.ownerName));
  }

  FutureOr<void> _changePhone(ChangePhone event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(mobile: event.mobile));
  }

  FutureOr<void> _isDealer(IsDealer event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(
        isDealerUnit: event.isDealer,
        isSubDealerUnit: !event.isDealer ? false : state.isSubDealerUnit,
        selectedDealearCompanyId:
            !event.isDealer ? '' : state.selectedDealearCompanyId,
        selectedDealearId: !event.isDealer ? state.selectedDealearId : -1));
  }

  FutureOr<void> _isSubDealer(IsSubDealer event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(isSubDealerUnit: event.isSubDealer));
  }

  FutureOr<void> _isRetailer(IsRetailer event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(asRetailer: event.isRetailer));
  }

  FutureOr<void> _getDealer(GetDealer event, Emitter<AddUnitState> emit) async {
    if ((state.asRetailer || state.isSubDealerUnit) &&
        state.selectedZoneId != -1) {
      final dealerResponse = await _apiRepo.post(
        endpoint: dealerUnitsGetEndpoint,
        body: DealerUnits(
          companyId:
              await LocalData.getCompanyId(localStorageRepo: _localStorageRepo),
          zoneId: state.selectedZoneId != -1 ? state.selectedZoneId : null,
        ),
        responseModel: const UnitResponse(),
      );
      emit(state.copyWith(dealerLoading: false));
      if (dealerResponse != null) {
        final dealers = <DropdownItem>[];
        for (int i = 0; i < dealerResponse.data!.length; i++) {
          dealers.add(DropdownItem(
              name:
                  '${dealerResponse.data![i].name!} (${dealerResponse.data![i].mobile!}) : ${dealerResponse.data![i].unitType!}',
              value: dealerResponse.data![i].id!));
        }
        emit(state.copyWith(dealers: dealers));
      }
    }
  }

  FutureOr<void> _getDealerId(GetDealerId event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(selectedDealearId: event.dealerId));
  }

  FutureOr<void> _getDistrict(
      GetDistrict event, Emitter<AddUnitState> emit) async {
    emit(state.copyWith(districtLoading: true));
    final getDistrict = await _apiRepo.post(
        endpoint: districtsGetEndpoint, responseModel: const DistrictList());
    emit(state.copyWith(districtLoading: false));
    if (getDistrict != null) {
      final matchDropdown = <DropdownItem>[];
      for (int i = 0; i < getDistrict.data!.length; i++) {
        matchDropdown.add(DropdownItem(
            name: getDistrict.data![i].name!, value: getDistrict.data![i].id!));
      }
      emit(state.copyWith(districtList: matchDropdown));
    }
  }

  FutureOr<void> _districtSelected(
      DistrictSelected event, Emitter<AddUnitState> emit) {
    if (event.districtId != state.selectedDistrictId) {
      final upazilasList = <DropdownItem>[];
      emit(state.copyWith(
        selectedDistrictId: event.districtId,
        setupazilas: true,
        selectedUpazilaId: -1,
        upazilas: upazilasList,
      ));
      if (state.selectedDistrictId != -1) {
        add(GetUpazilas());
      }
    }
  }

  FutureOr<void> _getUpazilas(
      GetUpazilas event, Emitter<AddUnitState> emit) async {
    emit(state.copyWith(subDistrictLoading: true));
    final getUpazila = await _apiRepo.post(
      endpoint: upazilasGetEndpoint,
      body: DistrictId(districtId: state.selectedDistrictId),
      responseModel: const Upazilas(),
    );
    emit(state.copyWith(subDistrictLoading: false));
    if (getUpazila != null) {
      final upazilas = <DropdownItem>[];
      for (int i = 0; i < getUpazila.data!.length; i++) {
        upazilas.add(
          DropdownItem(
              name: getUpazila.data![i].name!, value: getUpazila.data![i].id!),
        );
      }
      emit(state.copyWith(upazilas: upazilas));
    }
  }

  FutureOr<void> _getUpazilaId(GetUpazilaId event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(selectedUpazilaId: event.upazilaId));
  }

  FutureOr<void> _changeAddress(
      ChangeAddress event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(address: event.address));
  }

  FutureOr<void> _getZone(GetZone event, Emitter<AddUnitState> emit) async {
    emit(state.copyWith(zoneLoading: true));
    final zones = await _apiRepo.post(
      endpoint: zonesEndpoint,
      body: CompanyId(
          companyId: await LocalData.getCompanyId(
                  localStorageRepo: _localStorageRepo) ??
              -1),
      responseModel: const Zones(),
    );
    emit(state.copyWith(zoneLoading: false));
    if (zones != null) {
      final zoneItems = <DropdownItem>[];
      for (int i = 0; i < zones.data!.length; i++) {
        zoneItems.add(DropdownItem(
            name: zones.data![i].name!, value: zones.data![i].id!));
      }
      emit(state.copyWith(zoneList: zoneItems));
    }
  }

  FutureOr<void> _zoneSelected(ZoneSelected event, Emitter<AddUnitState> emit) {
    if (event.zoneId != state.selectedZoneId) {
      emit(state.copyWith(
          selectedZoneId: event.zoneId,
          resetArea: true,
          selectedAreaId: -1,
          resetDealer: true,
          selectedDealearId: -1,
          setCompany: true,
          selectedDealearCompanyId: '',
          areaLoading: true,
          dealerLoading: !state.isDealerUnit ? true : false));
      add(GetAreas());
      if (state.asRetailer || state.isSubDealerUnit) {
        add(GetDealer());
      }
    }
  }

  FutureOr<void> _getAreas(GetAreas event, Emitter<AddUnitState> emit) async {
    final areas = await _apiRepo.post(
        endpoint: areasGetEndpoint,
        body: ZoneId(zoneId: state.selectedZoneId),
        responseModel: const Areas());
    emit(state.copyWith(areaLoading: false));
    if (areas != null) {
      final areaList = <DropdownItem>[];
      for (int i = 0; i < areas.data!.length; i++) {
        areaList.add(DropdownItem(
            name: areas.data![i].name!, value: areas.data![i].id!));
      }
      emit(state.copyWith(areaList: areaList));
    }
  }

  FutureOr<void> _getAreaId(GetAreaId event, Emitter<AddUnitState> emit) {
    emit(state.copyWith(selectedAreaId: event.areaId));
  }

//Save unit
  FutureOr<void> _pressToContinue(
      PressToContinue event, Emitter<AddUnitState> emit) async {
    if (isValid(event.unitNameFocusNode, event.addressFocusNode,
            event.ownerNameFocusNode, event.phoneFocusNode) &&
        !state.loading) {
      emit(state.copyWith(loading: true));

      final unitSave = await _apiRepo.post(
        endpoint: unitsSave,
        body: UnitSave(
            companyId: await LocalData.getCompanyId(
                localStorageRepo: _localStorageRepo),
            unitTypeId: state.selectedunitTypeId,
            name: state.unitName,
            owner: state.ownerName,
            mobile: state.mobile,
            districtId: state.selectedDistrictId,
            upazilaId: state.selectedUpazilaId,
            address: state.address,
            zoneId: state.selectedZoneId,
            asDealer: state.isDealerUnit,
            dealerId:
                state.selectedDealearId == -1 ? null : state.selectedDealearId,
            asSubDealer: state.isSubDealerUnit,
            dealerCompanyId: state.selectedDealearCompanyId,
            areaId: state.selectedAreaId == -1 ? null : state.selectedAreaId,
            asRetailer: state.asRetailer),
        responseModel: const UnitSaveResponse(),
      );

      if (unitSave != null) {
        _iFlutterNavigator.pushReplacement(UnitListScreen.route());
        ShowSnackBar(navigator: _iFlutterNavigator, message: unitSave.message!);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<AddUnitState> emit) {
    if (event.name == PopUpMenu.allUnit.name) {
      _iFlutterNavigator.push(UnitListScreen.route());
    } else if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.push(DashBoardScreen.route());
    }
  }

// Units Get Conditional Fields
  FutureOr<void> _unitsGetConditionalFields(
      UnitsGetConditionalFields event, Emitter<AddUnitState> emit) async {
    emit(state.copyWith(resetRadioGroup: true));

    final unitsConditionalFields = await _apiRepo.post(
      endpoint: unitsGetConditionalFieldsEndpoint,
      body: UnitTypesId(unitTypeId: state.selectedunitTypeId),
      responseModel: const UnitsConditionalFields(),
    );
    if (unitsConditionalFields != null) {
      emit(state.copyWith(unitsConditionalField: unitsConditionalFields));
      if (state.dealers.isEmpty) {
        add(const IsRetailer(isRetailer: true));
        add(GetDealer());
      }
    }
  }

  bool isValid(
    FocusNode unitNameFocusNode,
    FocusNode addressFocusNode,
    FocusNode ownerNameFocusNode,
    FocusNode phoneFocusNode,
  ) {
    final valid = Validator.isValidated(items: [
      FormItem(text: state.unitName, focusNode: unitNameFocusNode),
      FormItem(text: state.ownerName, focusNode: ownerNameFocusNode),
      FormItem(text: state.mobile, focusNode: phoneFocusNode),
      FormItem(text: state.address, focusNode: addressFocusNode),
    ], navigator: _iFlutterNavigator);

    if (!valid) return false;

    if (state.selectedunitTypeId == -1 ||
        state.selectedDistrictId == -1 ||
        state.selectedUpazilaId == -1 ||
        state.selectedZoneId == -1 ||
        (state.unitsConditionalField.canSetDealerCompanyName! &&
            state.isDealerUnit &&
            state.selectedDealearCompanyId == '') ||
        (state.unitsConditionalField.canSetUnitUnderDealer! &&
            !state.isDealerUnit &&
            state.selectedDealearId == -1)) {
      return false;
    }

    return true;
  }

  FutureOr<void> _checkZoneIsSelected(
      CheckZoneIsSelected event, Emitter<AddUnitState> emit) {
    if (state.selectedZoneId == -1) {
      ShowSnackBar(
          message: 'Select Zone', navigator: _iFlutterNavigator, error: true);
    }
  }
}
