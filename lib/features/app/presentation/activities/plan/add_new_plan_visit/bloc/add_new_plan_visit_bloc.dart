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
import 'package:work_diary/features/app/data/models/area_visit_save.dart';
import 'package:work_diary/features/app/data/models/company_id.dart';
import 'package:work_diary/features/app/data/models/get_plan.dart';
import 'package:work_diary/features/app/data/models/unit_by_plan.dart';
import 'package:work_diary/features/app/data/models/unit_type_id.dart';
import 'package:work_diary/features/app/domain/entities/plan_list_response.dart';
import 'package:work_diary/features/app/domain/entities/unit_type.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/entities/update_visit.dart';
import 'package:work_diary/features/app/domain/entities/visit_objective.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan/view/add_new_plan_screen.dart';

part 'add_new_plan_visit_event.dart';
part 'add_new_plan_visit_state.dart';

class AddNewPlanVisitBloc
    extends Bloc<AddNewPlanVisitEvent, AddNewPlanVisitState> {
  AddNewPlanVisitBloc(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(AddNewVisitPlanInitial()) {
    on<GetCompanyIdEvent>(_getCompanyIdEvent);
    on<GetVisitObjectiveEvent>(_getVisitObjectiveEvent);
    on<GetUnits>(_getUnits);
    on<SelectDate>(_selectDate);
    on<UnitSelected>(_unitSelected);
    on<UnitTypeSelected>(_unitTypeSelected);
    on<GetObjEvent>(_getObjEvent);
    on<VisitNoteChangedEvent>(_visitNoteChangedEvent);
    on<CreateVisitEvent>(_createVisitEvent);
    on<MenuItemScreens>(_menuItemScreens);
    on<GetPlanList>(_getPlanList);
    on<PlanSelected>(_planSelected);
    on<GoToCreateNewPlan>(_goToCreateNewPlan);
  }
  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _selectDate(
      SelectDate event, Emitter<AddNewPlanVisitState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(event.date));

    event.dateController.text = date;
  }

  FutureOr<void> _getCompanyIdEvent(
      GetCompanyIdEvent event, Emitter<AddNewPlanVisitState> emit) async {
    emit(state.copyWith(
        companyId:
            await LocalData.getCompanyId(localStorageRepo: _localStorageRepo),
        unitMessage: await LocalData.getCompanyUnitName(
            localStorageRepo: _localStorageRepo)));

    add(GetVisitObjectiveEvent());
    add(GetPlanList(planId: event.planId));
  }

  FutureOr<void> _getVisitObjectiveEvent(
      GetVisitObjectiveEvent event, Emitter<AddNewPlanVisitState> emit) async {
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

  Future<FutureOr<void>> _getUnits(
      GetUnits event, Emitter<AddNewPlanVisitState> emit) async {
    emit(state.copyWith(unitLoading: true));
    final units = await _apiRepo.post(
        endpoint: getUnitByPlanEndpoint,
        body: UnitByPlan(companyId: state.companyId, planId: event.planId),
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
      UnitSelected event, Emitter<AddNewPlanVisitState> emit) async {
    if (event.unitIndex != -1 && state.currentUnitIndex != event.unitIndex) {
      emit(state.copyWith(
          currentUnitIndex: event.unitIndex,
          companyUnitId: state.units.data![event.unitIndex].companyUnitId,
          setUnitType: true,
          selectedUnitType: -1,
          unitTypeList: []));

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
          final unitTypeList = <DropdownItem>[];
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

  FutureOr<void> _getObjEvent(
      GetObjEvent event, Emitter<AddNewPlanVisitState> emit) {
    emit(state.copyWith(selectedObj: event.objectives));
  }

  FutureOr<void> _visitNoteChangedEvent(
      VisitNoteChangedEvent event, Emitter<AddNewPlanVisitState> emit) {
    emit(state.copyWith(visitNote: event.visitNote));
  }

  FutureOr<void> _createVisitEvent(
      CreateVisitEvent event, Emitter<AddNewPlanVisitState> emit) async {
    if (isValid() && !state.loading) {
      emit(state.copyWith(loading: true));
      final sendData = await _apiRepo.post(
          endpoint: visitAreaWiseSaveEndpoint,
          body: AreaVisitSave(
              companyUnitId: state.companyUnitId,
              objectives: state.selectedObj,
              unitTypeId: state.selectedUnitType,
              visitNote: state.visitNote,
              planId: state.selectedPlan),
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
      UnitTypeSelected event, Emitter<AddNewPlanVisitState> emit) {
    if (event.unitIndex != -1) {
      emit(state.copyWith(
          selectedUnitType: state.unitType.data![event.unitIndex].id));
    }
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<AddNewPlanVisitState> emit) {
    if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.popUntil((route) => route.isFirst);
    } else if (event.name == PopUpMenu.allVisitPlan.name) {
      _iFlutterNavigator.pop();
    } else if (event.name == PopUpMenu.createNewPlan.name) {
      add(GoToCreateNewPlan());
    }
  }

  bool isValid() {
    if (state.selectedPlan == -1 ||
        state.selectedObj.isEmpty ||
        state.currentUnitIndex == -1 ||
        state.selectedUnitType == -1) {
      return false;
    }

    return true;
  }

  Future<FutureOr<void>> _getPlanList(
      GetPlanList event, Emitter<AddNewPlanVisitState> emit) async {
    emit(state.copyWith(
        forms: Forms.initial,
        planDate: '',
        resetPlan: true,
        setUnits: true,
        setUnitType: true,
        selectedPlan: -1,
        currentUnitIndex: -1,
        companyUnitId: -1,
        selectedUnitType: -1,
        planLoading: true));
    final planResponse = await _apiRepo.post(
        endpoint: planListEndpoint,
        body: GetPlan(companyId: state.companyId, plansFor: 'own'),
        responseModel: const PlanListResponse());
    emit(state.copyWith(planLoading: false));
    if (planResponse != null) {
      List<DropdownItem> planList = [];
      for (int i = 0; i < planResponse.data!.length; i++) {
        if (i == 0 ||
            (i > 0 &&
                planResponse.data![i].dateFor !=
                    planResponse.data![i - 1].dateFor)) {
          planList.add(DropdownItem(
              name: planResponse.data![i].dateFor!, value: -1 * (i + 1)));
        }
        planList.add(DropdownItem(
            name: planResponse.data![i].name!,
            value: planResponse.data![i].id!));
      }
      emit(state.copyWith(planList: planList, planListResponse: planResponse));
      if (event.planId != null) {
        add(PlanSelected(planId: event.planId!));
      }
    }
  }

  FutureOr<void> _planSelected(
      PlanSelected event, Emitter<AddNewPlanVisitState> emit) {
    if (state.selectedPlan != event.planId) {
      emit(state.copyWith(
          selectedPlan: event.planId,
          setUnits: true,
          setUnitType: true,
          currentUnitIndex: -1,
          companyUnitId: -1,
          selectedUnitType: -1,
          unitTypeList: [],
          unitList: []));

      for (int i = 0; i < state.planListResponse.data!.length; i++) {
        if (state.planListResponse.data![i].id == event.planId) {
          emit(state.copyWith(
              planDate: state.planListResponse.data![i].dateFor));
          break;
        }
      }

      add(GetUnits(planId: event.planId));
    }
  }

  FutureOr<void> _goToCreateNewPlan(
      GoToCreateNewPlan event, Emitter<AddNewPlanVisitState> emit) {
    _iFlutterNavigator.push(AddNewPlanScreen.route()).then((value) {
      if (value != null) {
        add(const GetPlanList());
      }
    });
  }
}
