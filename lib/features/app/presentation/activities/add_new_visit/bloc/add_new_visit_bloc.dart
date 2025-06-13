import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/company_id.dart';
import 'package:work_diary/features/app/data/models/crteate_visit.dart';
import 'package:work_diary/features/app/data/models/unit_type_id.dart';
import 'package:work_diary/features/app/data/models/visitor_model.dart';
import 'package:work_diary/features/app/domain/entities/unit_type.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/entities/update_visit.dart';
import 'package:work_diary/features/app/domain/entities/visit_objective.dart';
import 'package:work_diary/features/app/domain/entities/visitors.dart';
import 'package:work_diary/features/app/domain/entities/zone.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';

part 'add_new_visit_event.dart';
part 'add_new_visit_state.dart';

class AddNewVisitBloc extends Bloc<AddNewVisitEvent, AddNewVisitState> {
  AddNewVisitBloc(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(AddNewVisitPlanInitial()) {
    on<GetCompanyIdEvent>(_getCompanyIdEvent);
    on<GetVisitObjectiveEvent>(_getVisitObjectiveEvent);
    on<GetZoneIndexEvent>(_getZoneIndexEvent);
    on<GetUnits>(_getUnits);
    on<GetZoneEvent>(_getZoneEvent);
    on<SelectDate>(_selectDate);
    on<UnitSelected>(_unitSelected);
    on<UnitTypeSelected>(_unitTypeSelected);
    on<GetObjEvent>(_getObjEvent);
    on<VisitNoteChangedEvent>(_visitNoteChangedEvent);
    on<CreateVisitEvent>(_createVisitEvent);
    on<GetVisitorsEvent>(_getVisitorsEvent);
    on<VisitorSelected>(_visitorSelected);
    on<MenuItemScreens>(_menuItemScreens);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _selectDate(SelectDate event, Emitter<AddNewVisitState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(event.date));

    event.dateController.text = date;
    emit(state.copyWith(date: date));
  }

  FutureOr<void> _getCompanyIdEvent(
      GetCompanyIdEvent event, Emitter<AddNewVisitState> emit) async {
    final userId =
        await LocalData.getUserId(localStorageRepo: _localStorageRepo);
    emit(state.copyWith(
        companyId:
            await LocalData.getCompanyId(localStorageRepo: _localStorageRepo),
        unitMessage: await LocalData.getCompanyUnitName(
            localStorageRepo: _localStorageRepo),
        userId: userId,
        visitorId: event.visitorId ?? userId));

    add(GetVisitObjectiveEvent());
    add(GetVisitorsEvent());
  }

  FutureOr<void> _getVisitObjectiveEvent(
      GetVisitObjectiveEvent event, Emitter<AddNewVisitState> emit) async {
    emit(state.copyWith(objectiveLoading: true));
    final visitObjectiveResponse = await _apiRepo.post(
        endpoint: visitObjectivesEndpoint,
        body: CompanyId(companyId: state.companyId),
        responseModel: const VisitObjectives());
    emit(state.copyWith(objectiveLoading: false));
    if (visitObjectiveResponse != null) {
      final list = <DropdownItem>[];
      for (int i = 0; i < visitObjectiveResponse.data!.length; i++) {
        list.add(DropdownItem(
            name: visitObjectiveResponse.data![i].title!, value: i));
      }
      emit(state.copyWith(
          visitobjective: visitObjectiveResponse, visitObjectList: list));
    }
  }

  FutureOr<void> _getZoneEvent(
      GetZoneEvent event, Emitter<AddNewVisitState> emit) async {
    emit(state.copyWith(
        setZone: true,
        zoneIndex: -1,
        setUnits: true,
        currentUnitIndex: -1,
        setUnitType: true,
        selectedUnitType: -1,
        unitTypeList: [],
        unitList: [],
        zoneLoading: true));

    final zone = await _apiRepo.post(
        endpoint: zonesEndpointV2,
        body: CompanyId(companyId: state.companyId, visitorId: state.visitorId),
        responseModel: const Zones());
    emit(state.copyWith(zoneLoading: false));
    if (zone != null) {
      final zoneList = <DropdownItem>[];
      for (int i = 0; i < zone.data!.length; i++) {
        zoneList.add(DropdownItem(name: zone.data![i].name!, value: i));
      }
      if (zone.data!.isNotEmpty) {
        emit(state.copyWith(zonesList: zoneList, zones: zone));
        if (!isClosed) {
          add(const GetZoneIndexEvent(zoneIndex: 0));
        }
      }
    }
  }

  FutureOr<void> _getZoneIndexEvent(
      GetZoneIndexEvent event, Emitter<AddNewVisitState> emit) {
    if (state.zoneIndex != event.zoneIndex) {
      final unitList = <DropdownItem>[];
      emit(state.copyWith(
        setUnits: true,
        currentUnitIndex: -1,
        setUnitType: true,
        selectedUnitType: -1,
        unitTypeList: [],
        unitList: unitList,
        zoneIndex: event.zoneIndex,
      ));

      add(GetUnits(zoneId: state.zones.data![event.zoneIndex].id));
    }
  }

  Future<FutureOr<void>> _getUnits(
      GetUnits event, Emitter<AddNewVisitState> emit) async {
    emit(state.copyWith(unitLoading: true));
    final units = await _apiRepo.post(
        endpoint: companyUnitEndpointV2,
        body: CompanyId(
            companyId: state.companyId,
            zoneId: event.zoneId,
            visitorId: state.visitorId),
        responseModel: const UnitResponse());

    emit(state.copyWith(unitLoading: false));

    if (units != null) {
      final unitList = <DropdownItem>[];
      for (int i = 0; i < units.data!.length; i++) {
        unitList.add(DropdownItem(
            name:
                "${units.data![i].code!} | ${units.data![i].name!} | ${units.data![i].mobile!} ${units.data![i].asDealer! ? '(As Dealer) ' : ''}: ${units.data![i].unitType!}",
            value: i));
      }
      emit(state.copyWith(units: units, unitList: unitList));
    }
  }

  FutureOr<void> _unitSelected(
      UnitSelected event, Emitter<AddNewVisitState> emit) async {
    if (event.unitIndex != -1 && state.currentUnitIndex != event.unitIndex) {
      final unitTypeList = <DropdownItem>[];
      emit(state.copyWith(
          currentUnitIndex: event.unitIndex,
          companyUnitId: state.units.data![event.unitIndex].companyUnitId,
          setUnitType: true,
          selectedUnitType: -1,
          unitTypeList: unitTypeList));

      if (event.unitIndex != -1) {
        emit(state.copyWith(unitTypeLoading: true));
        final unitTypes = await _apiRepo.post(
          endpoint: getUnitTypesEndpoint,
          body: UnitTypesId(
              unitTypeId: state.units.data![event.unitIndex].unitTypeId!),
          responseModel: const UnitTypes(),
        );
        emit(state.copyWith(unitTypeLoading: false));
        if (unitTypes != null) {
          for (int i = 0; i < unitTypes.data!.length; i++) {
            if (unitTypes.data!.length == 1) {
              emit(state.copyWith(selectedUnitType: unitTypes.data![0].id));
            } else {
              unitTypeList
                  .add(DropdownItem(name: unitTypes.data![i].name!, value: i));
            }
          }
          emit(state.copyWith(unitTypeList: unitTypeList, unitType: unitTypes));
        }
      }
    }
  }

  FutureOr<void> _getVisitorsEvent(
      GetVisitorsEvent event, Emitter<AddNewVisitState> emit) async {
    final visitorList = <DropdownItem>[];
    emit(state.copyWith(assigneeLoading: true));
    final visitorResponse = await _apiRepo.post(
      endpoint: getVisitorsEndpointV2,
      body: VisitorModel(
        userId: state.userId,
        companyId: state.companyId,
      ),
      responseModel: const Visitors(),
    );
    emit(state.copyWith(assigneeLoading: false));
    visitorList.add(DropdownItem(name: 'Me', value: state.userId));
    if (visitorResponse != null) {
      for (int i = 0; i < visitorResponse.data!.length; i++) {
        visitorList.add(DropdownItem(
            name: visitorResponse.data![i].name!,
            value: visitorResponse.data![i].id!));
      }
      emit(state.copyWith(visitors: visitorResponse));
    }
    emit(state.copyWith(visitorList: visitorList));

    add(GetZoneEvent());
  }

  FutureOr<void> _getObjEvent(
      GetObjEvent event, Emitter<AddNewVisitState> emit) {
    emit(state.copyWith(selectedObj: event.objectives));
    print(state.selectedObj);

  }

  FutureOr<void> _visitNoteChangedEvent(
      VisitNoteChangedEvent event, Emitter<AddNewVisitState> emit) {
    emit(state.copyWith(visitNote: event.visitNote));
  }

  Future<FutureOr<void>> _visitorSelected(
      VisitorSelected event, Emitter<AddNewVisitState> emit) async {
    if (state.visitorId != event.visitorId) {
      emit(state.copyWith(visitorId: event.visitorId));
      add(GetZoneEvent());
    }
  }

  FutureOr<void> _createVisitEvent(
      CreateVisitEvent event, Emitter<AddNewVisitState> emit) async {
    if (isValid() && !state.loading) {
      emit(state.copyWith(loading: true));
      final sendData = await _apiRepo.post(
          endpoint: visitCreateEndpoint,
          body: CreateVisit(
              assignTo: state.visitorId != -1 ? state.visitorId : null,
              companyUnitId: state.companyUnitId,
              dateFor: state.date,
              objectives: state.selectedObj,
              unitTypeId: state.selectedUnitType,
              visitNote: state.visitNote),
          responseModel: const UpdateVisit());
      emit(state.copyWith(loading: false));

      if (sendData != null) {
        ShowSnackBar(message: sendData.message!, navigator: _iFlutterNavigator);
        _iFlutterNavigator.pop(sendData.data);
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _unitTypeSelected(
      UnitTypeSelected event, Emitter<AddNewVisitState> emit) {
    if (event.unitIndex != -1) {
      emit(state.copyWith(
          selectedUnitType: state.unitType.data![event.unitIndex].id));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<AddNewVisitState> emit) {
    if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.popUntil((route) => route.isFirst);
    } else if (event.name == PopUpMenu.allVisitPlan.name) {
      _iFlutterNavigator.pop();
    }
  }

  bool isValid() {
    if (state.date.isEmpty ||
        state.selectedObj.isEmpty ||
        state.zoneIndex == -1 ||
        state.currentUnitIndex == -1 ||
        state.selectedUnitType == -1) {
      return false;
    }

    return true;
  }
}
