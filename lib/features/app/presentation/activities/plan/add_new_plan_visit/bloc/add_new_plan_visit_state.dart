part of 'add_new_plan_visit_bloc.dart';

class AddNewPlanVisitState extends Equatable {
  const AddNewPlanVisitState(
      {this.visitobjective = const VisitObjectives(),
      this.visitObjectList = const [],
      this.units = const UnitResponse(),
      this.unitList = const [],
      this.companyId = -1,
      this.setUnits = false,
      this.currentUnitIndex = -1,
      this.companyUnitId = -1,
      this.selectedObj = const [],
      this.unitType = const UnitTypes(),
      this.unitTypeList = const [],
      this.selectedUnitType = -1,
      this.visitNote = "",
      this.setUnitType = false,
      this.forms = Forms.initial,
      this.loading = false,
      this.unitMessage = '',
      this.planList = const [],
      this.selectedPlan = -1,
      this.resetPlan = false,
      this.planDate = '',
      this.planListResponse = const PlanListResponse(),
      this.planLoading = false,
      this.unitLoading = false,
      this.unitTypeLoading = false,
      this.objectiveLoading = false});

  final int companyId;
  final VisitObjectives visitobjective;
  final List<DropdownItem> visitObjectList;
  final UnitResponse units;
  final List<DropdownItem> unitList;
  final bool setUnits;
  final int currentUnitIndex;
  final int companyUnitId;
  final List<String> selectedObj;
  final String visitNote;
  final UnitTypes unitType;
  final List<DropdownItem> unitTypeList;
  final int selectedUnitType;
  final bool setUnitType;
  final Forms forms;
  final bool loading;
  final String unitMessage;
  final List<DropdownItem> planList;
  final int selectedPlan;
  final bool resetPlan;
  final String planDate;
  final PlanListResponse planListResponse;
  final bool planLoading, unitLoading, unitTypeLoading, objectiveLoading;

  AddNewPlanVisitState copyWith(
      {int? companyId,
      VisitObjectives? visitobjective,
      List<DropdownItem>? visitObjectList,
      UnitResponse? units,
      List<DropdownItem>? unitList,
      bool? setUnits,
      bool? setUnitType,
      int? currentUnitIndex,
      int? companyUnitId,
      List<String>? selectedObj,
      String? visitNote,
      UnitTypes? unitType,
      List<DropdownItem>? unitTypeList,
      int? selectedUnitType,
      Forms? forms,
      bool? loading,
      String? unitMessage,
      List<DropdownItem>? planList,
      int? selectedPlan,
      bool? resetPlan,
      String? planDate,
      PlanListResponse? planListResponse,
      bool? planLoading,
      bool? unitLoading,
      bool? unitTypeLoading,
      bool? objectiveLoading}) {
    return AddNewPlanVisitState(
        visitobjective: visitobjective ?? this.visitobjective,
        visitObjectList: visitObjectList ?? this.visitObjectList,
        companyId: companyId ?? this.companyId,
        units: units ?? this.units,
        unitList: unitList ?? this.unitList,
        setUnits: setUnits ?? false,
        setUnitType: setUnitType ?? false,
        currentUnitIndex: currentUnitIndex ?? this.currentUnitIndex,
        companyUnitId: companyUnitId ?? this.companyUnitId,
        selectedObj: selectedObj ?? this.selectedObj,
        visitNote: visitNote ?? this.visitNote,
        unitType: unitType ?? this.unitType,
        unitTypeList: unitTypeList ?? this.unitTypeList,
        selectedUnitType: selectedUnitType ?? this.selectedUnitType,
        forms: forms ?? this.forms,
        loading: loading ?? this.loading,
        unitMessage: unitMessage ?? this.unitMessage,
        planList: planList ?? this.planList,
        selectedPlan: selectedPlan ?? this.selectedPlan,
        resetPlan: resetPlan ?? false,
        planDate: planDate ?? this.planDate,
        planListResponse: planListResponse ?? this.planListResponse,
        planLoading: planLoading ?? this.planLoading,
        unitLoading: unitLoading ?? this.unitLoading,
        unitTypeLoading: unitTypeLoading ?? this.unitTypeLoading,
        objectiveLoading: objectiveLoading ?? this.objectiveLoading);
  }

  @override
  List<Object> get props => [
        visitobjective,
        visitObjectList,
        companyId,
        units,
        unitList,
        setUnits,
        setUnitType,
        currentUnitIndex,
        selectedObj,
        visitNote,
        unitType,
        unitTypeList,
        selectedUnitType,
        forms,
        loading,
        unitMessage,
        planList,
        selectedPlan,
        resetPlan,
        planDate,
        planListResponse,
        planLoading,
        unitLoading,
        unitTypeLoading,
        objectiveLoading
      ];
}

class AddNewVisitPlanInitial extends AddNewPlanVisitState {}
