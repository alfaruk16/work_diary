import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/company_id.dart';
import 'package:work_diary/features/app/data/models/company_unit_id.dart';
import 'package:work_diary/features/app/data/models/create_emergency_task.dart';
import 'package:work_diary/features/app/data/models/unit_type_id.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/unit_type.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/entities/visit_objective.dart';
import 'package:work_diary/features/app/domain/entities/visitors.dart';
import 'package:work_diary/features/app/domain/entities/zone.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';

part 'add_new_emergency_issue_event.dart';
part 'add_new_emergency_issue_state.dart';

class AddNewEmergencyIssueBloc
    extends Bloc<AddNewEmergencyIssueEvent, AddNewEmergencyIssueState> {
  AddNewEmergencyIssueBloc(
      this._flutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(AddNewEmergencyIssueInitial()) {
    on<GetCompanyIdEvent>(_getCompanyIdEvent);
    on<GetVisitObjectiveEvent>(_getVisitObjectiveEvent);
    on<GetZoneIndexEvent>(_getZoneIndexEvent);
    on<GetUnits>(_getUnits);
    on<GetZoneEvent>(_getZoneEvent);
    on<SelectDate>(_selectDate);
    on<UnitSelected>(_unitSelected);
    on<UnitTypeSelected>(_unitTypeSelected);
    on<GetObjEvent>(_getObjEvent);
    on<TaskNote>(_taskNote);
    on<CreateEmergencyIssue>(_createEmergencyIssue);
    on<GetVisitorsEvent>(_getVisitorsEvent);
    on<VisitorSelected>(_visitorSelected);
    on<MenuItemScreens>(_menuItemScreens);

    add(GetCompanyIdEvent());
    add(GetVisitObjectiveEvent());
    add(GetZoneEvent());
  }

  final IFlutterNavigator _flutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _selectDate(
      SelectDate event, Emitter<AddNewEmergencyIssueState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(event.date));

    event.dateController.text = date;
    emit(state.copyWith(date: date));
  }

  FutureOr<void> _getCompanyIdEvent(
      GetCompanyIdEvent event, Emitter<AddNewEmergencyIssueState> emit) async {
    emit(state.copyWith(
        companyId:
            await LocalData.getCompanyId(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _getVisitObjectiveEvent(GetVisitObjectiveEvent event,
      Emitter<AddNewEmergencyIssueState> emit) async {
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
      GetZoneEvent event, Emitter<AddNewEmergencyIssueState> emit) async {
    emit(state.copyWith(zoneLoading: true));
    final zone = await _apiRepo.post(
        endpoint: zonesEndpoint,
        body: CompanyId(companyId: state.companyId),
        responseModel: const Zones());
    emit(state.copyWith(zoneLoading: false));
    if (zone != null) {
      final zoneList = <DropdownItem>[];
      for (int i = 0; i < zone.data!.length; i++) {
        zoneList.add(DropdownItem(name: zone.data![i].name!, value: i));
      }
      emit(state.copyWith(zonesList: zoneList, zones: zone));
    }
  }

  FutureOr<void> _getZoneIndexEvent(
      GetZoneIndexEvent event, Emitter<AddNewEmergencyIssueState> emit) {
    if (state.zoneIndex != event.zoneIndex) {
      final unitList = <DropdownItem>[];
      emit(state.copyWith(
          setUnits: true,
          setUnitType: true,
          setVisitors: true,
          unitList: unitList,
          currentUnitId: -1,
          zoneIndex: event.zoneIndex));

      add(GetUnits(zoneId: state.zones.data![event.zoneIndex].id));
    }
  }

//get Units
  Future<FutureOr<void>> _getUnits(
      GetUnits event, Emitter<AddNewEmergencyIssueState> emit) async {
    emit(state.copyWith(unitLoading: true));
    final units = await _apiRepo.post(
        endpoint: companyUnitEndpoint,
        body: CompanyId(companyId: state.companyId, zoneId: event.zoneId),
        responseModel: const UnitResponse());
    emit(state.copyWith(unitLoading: false));
    if (units != null) {
      final unitList = <DropdownItem>[];
      for (int i = 0; i < units.data!.length; i++) {
        unitList.add(DropdownItem(
            name:
                "${units.data![i].code!} | ${units.data![i].name!} | ${units.data![i].mobile!} ${units.data![i].asDealer! ? ' (As Dealer)' : ''}",
            value: i));
      }
      emit(state.copyWith(units: units, unitList: unitList));
    }
  }

//Selected Units
  FutureOr<void> _unitSelected(
      UnitSelected event, Emitter<AddNewEmergencyIssueState> emit) async {
    if (state.currentUnitId != event.unitIndex) {
      final unitTypeList = <DropdownItem>[];
      emit(state.copyWith(
          currentUnitId: event.unitIndex,
          setUnitType: true,
          setVisitors: true,
          unitTypeList: unitTypeList));

      add(GetVisitorsEvent());

      if (event.unitIndex != -1) {
        emit(state.copyWith(unitTypeLoading: true));
        final unitTypes = await _apiRepo.post(
          endpoint: getUnitTypesEndpoint,
          body: UnitTypesId(
              unitTypeId: state.units.data![event.unitIndex].unitTypeId!),
          responseModel: const UnitTypes(),
        );
        emit(state.copyWith(unitTypeLoading: false));
        for (int i = 0; i < unitTypes!.data!.length; i++) {
          unitTypeList
              .add(DropdownItem(name: unitTypes.data![i].name!, value: i));
        }
        emit(state.copyWith(unitTypeList: unitTypeList, unitType: unitTypes));
      }
    }
  }

  FutureOr<void> _getVisitorsEvent(
      GetVisitorsEvent event, Emitter<AddNewEmergencyIssueState> emit) async {
    if (state.currentUnitId != -1) {
      final visitorList = <DropdownItem>[];
      visitorList.add(const DropdownItem(name: 'Me', value: 0));
      emit(state.copyWith(assigneeLoading: true));
      final visitorResponse = await _apiRepo.post(
        endpoint: getVisitorsEndpoint,
        body: CompanyUnitId(
          companyUnitId: state.units.data![state.currentUnitId].companyUnitId!,
        ),
        responseModel: const Visitors(),
      );
      emit(state.copyWith(assigneeLoading: false));
      for (int i = 0; i < visitorResponse!.data!.length; i++) {
        visitorList.add(DropdownItem(
            name: visitorResponse.data![i].name!,
            value: visitorResponse.data![i].id!));
      }
      emit(state.copyWith(visitorList: visitorList, visitors: visitorResponse));
    }
  }

  FutureOr<void> _getObjEvent(
      GetObjEvent event, Emitter<AddNewEmergencyIssueState> emit) {
    emit(state.copyWith(selectedObj: event.objectives));
  }

  FutureOr<void> _taskNote(
      TaskNote event, Emitter<AddNewEmergencyIssueState> emit) {
    emit(state.copyWith(taskNote: event.taskNote));
  }

  FutureOr<void> _visitorSelected(
      VisitorSelected event, Emitter<AddNewEmergencyIssueState> emit) {
    emit(state.copyWith(visitorId: event.visitorId));
  }

  FutureOr<void> _createEmergencyIssue(CreateEmergencyIssue event,
      Emitter<AddNewEmergencyIssueState> emit) async {
    if (isValided() && !state.loading) {
      emit(state.copyWith(loading: true));

      final sendData = await _apiRepo.post(
          endpoint: emergencyTaskCreateEndpoint,
          body: CreateEmergencyTask(
              assignTo: state.visitorId != 0 ? state.visitorId : null,
              companyUnitId:
                  state.units.data![state.currentUnitId].companyUnitId!,
              dateFor: state.date,
              objectives: state.selectedObj,
              unitTypeId: state.selectedUnitType,
              taskNote: state.taskNote),
          responseModel: const DefaultResponse());
      emit(state.copyWith(loading: false));

      if (sendData != null) {
        ShowSnackBar(message: sendData.message!, navigator: _flutterNavigator);
        _flutterNavigator.pop();
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _unitTypeSelected(
      UnitTypeSelected event, Emitter<AddNewEmergencyIssueState> emit) {
    if (event.unitIndex != -1) {
      emit(state.copyWith(
          selectedUnitType: state.unitType.data![event.unitIndex].id));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<AddNewEmergencyIssueState> emit) {
    if (event.name == PopUpMenu.allEmergencyIssue.name) {
      _flutterNavigator.pop();
    }
  }

  bool isValided() {
    if (state.date.isEmpty ||
        state.selectedObj.isEmpty ||
        state.zoneIndex == -1 ||
        state.currentUnitId == -1 ||
        state.selectedUnitType == -1) {
      return false;
    }

    return true;
  }
}
