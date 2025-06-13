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
import 'package:work_diary/features/app/data/models/create_plan.dart';
import 'package:work_diary/features/app/data/models/visitor_model.dart';
import 'package:work_diary/features/app/data/models/zone_id.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';

part 'add_new_plan_event.dart';
part 'add_new_plan_state.dart';

class AddNewPlanBloc extends Bloc<AddNewPlanEvent, AddNewPlanState> {
  AddNewPlanBloc(this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(AddNewVisitPlanInitial()) {
    on<GetCompanyIdEvent>(_getCompanyIdEvent);
    on<GetZoneIndexEvent>(_getZoneIndexEvent);
    on<GetArea>(_getArea);
    on<GetZoneEvent>(_getZoneEvent);
    on<SelectDate>(_selectDate);
    on<AreaSelected>(_areaSelected);
    on<VisitNoteChangedEvent>(_visitNoteChangedEvent);
    on<CreateVisitEvent>(_createVisitEvent);
    on<GetVisitorsEvent>(_getVisitorsEvent);
    on<VisitorSelected>(_visitorSelected);
    on<MenuItemScreens>(_menuItemScreens);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _selectDate(SelectDate event, Emitter<AddNewPlanState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(event.date));

    event.dateController.text = date;
    emit(state.copyWith(date: date));
  }

  FutureOr<void> _getCompanyIdEvent(
      GetCompanyIdEvent event, Emitter<AddNewPlanState> emit) async {
    final userId =
        await LocalData.getUserId(localStorageRepo: _localStorageRepo);
    emit(state.copyWith(
        companyId:
            await LocalData.getCompanyId(localStorageRepo: _localStorageRepo),
        unitMessage: await LocalData.getCompanyUnitName(
            localStorageRepo: _localStorageRepo),
        userId: userId,
        visitorId: event.visitorId ?? userId));

    add(GetVisitorsEvent());
  }

  FutureOr<void> _getZoneEvent(
      GetZoneEvent event, Emitter<AddNewPlanState> emit) async {
    emit(state.copyWith(
        setZone: true,
        zoneId: -1,
        setArea: true,
        areaId: -1,
        areaList: [],
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
      GetZoneIndexEvent event, Emitter<AddNewPlanState> emit) {
    if (state.zoneId != state.zones.data![event.zoneIndex].id) {
      if (state.zoneId != event.zoneIndex) {
        final unitList = <DropdownItem>[];
        emit(state.copyWith(
          setArea: true,
          areaId: -1,
          areaList: unitList,
          zoneId: event.zoneIndex,
        ));

        add(GetArea(zoneId: state.zones.data![event.zoneIndex].id));
      }
    }
  }

  Future<FutureOr<void>> _getArea(
      GetArea event, Emitter<AddNewPlanState> emit) async {
    emit(state.copyWith(areaLoading: true));
    final areas = await _apiRepo.post(
        endpoint: areasGetEndpoint,
        body: ZoneId(zoneId: event.zoneId!),
        responseModel: const Areas());
    emit(state.copyWith(areaLoading: false));
    if (areas != null) {
      final areaList = <DropdownItem>[];
      for (int i = 0; i < areas.data!.length; i++) {
        areaList.add(DropdownItem(
            name: areas.data![i].name!, value: areas.data![i].id!));
      }
      emit(state.copyWith(areaList: areaList, areas: areas));
    }
  }

  FutureOr<void> _areaSelected(
      AreaSelected event, Emitter<AddNewPlanState> emit) async {
    emit(state.copyWith(areaId: event.areaId));
  }

  FutureOr<void> _getVisitorsEvent(
      GetVisitorsEvent event, Emitter<AddNewPlanState> emit) async {
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
    for (int i = 0; i < visitorResponse!.data!.length; i++) {
      visitorList.add(DropdownItem(
          name: visitorResponse.data![i].name!,
          value: visitorResponse.data![i].id!));
    }
    emit(state.copyWith(visitorList: visitorList, visitors: visitorResponse));
    add(GetZoneEvent());
  }

  FutureOr<void> _visitNoteChangedEvent(
      VisitNoteChangedEvent event, Emitter<AddNewPlanState> emit) {
    emit(state.copyWith(visitNote: event.visitNote));
  }

  Future<FutureOr<void>> _visitorSelected(
      VisitorSelected event, Emitter<AddNewPlanState> emit) async {
    if (event.visitorId != state.visitorId) {
      if (event.visitorId != 0) {
        emit(state.copyWith(visitorId: event.visitorId));
      } else {
        emit(state.copyWith(
            visitorId: await LocalData.getUserId(
                localStorageRepo: _localStorageRepo)));
      }
      add(GetZoneEvent());
    }
  }

  FutureOr<void> _createVisitEvent(
      CreateVisitEvent event, Emitter<AddNewPlanState> emit) async {
    if (isValid() && !state.loading) {
      emit(state.copyWith(loading: true));
      final createPlan = await _apiRepo.post(
          endpoint: createPlanEndpoint,
          body: CreatePlan(
              zoneId: state.zones.data![state.zoneId].id!,
              areaId: state.areaId != -1 ? state.areaId : null,
              dateFor: state.date,
              assignTo: state.visitorId,
              comments: state.visitNote),
          responseModel: const UpdateVisit());

      emit(state.copyWith(loading: false));

      if (createPlan != null) {
        ShowSnackBar(
            message: createPlan.message!, navigator: _iFlutterNavigator);
        _iFlutterNavigator.pop(createPlan.data);
      }
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<AddNewPlanState> emit) {
    if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.popUntil((route) => route.isFirst);
    } else if (event.name == PopUpMenu.allVisitPlan.name) {
      _iFlutterNavigator.pop();
    }
  }

  bool isValid() {
    if (state.date.isEmpty || state.zoneId == -1) {
      return false;
    }
    return true;
  }
}
