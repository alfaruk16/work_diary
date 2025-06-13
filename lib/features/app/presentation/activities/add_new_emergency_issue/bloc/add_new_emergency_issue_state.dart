part of 'add_new_emergency_issue_bloc.dart';

class AddNewEmergencyIssueState extends Equatable {
  const AddNewEmergencyIssueState(
      {this.visitobjective = const VisitObjectives(),
      this.visitObjectList = const [],
      this.zones = const Zones(),
      this.zonesList = const [],
      this.zoneIndex = -1,
      this.units = const UnitResponse(),
      this.unitList = const [],
      this.date = '',
      this.companyId = -1,
      this.setUnits = false,
      this.currentUnitId = -1,
      this.selectedObj = const [],
      this.unitType = const UnitTypes(),
      this.unitTypeList = const [],
      this.selectedUnitType = -1,
      this.taskNote = "",
      this.setUnitType = false,
      this.setVisitors = false,
      this.visitors = const Visitors(),
      this.visitorList = const [],
      this.visitorId = 0,
      this.forms = Forms.initial,
      this.loading = false,
      this.objectiveLoading = false,
      this.assigneeLoading = false,
      this.zoneLoading = false,
      this.unitLoading = false,
      this.unitTypeLoading = false});

  final int companyId;
  final VisitObjectives visitobjective;
  final List<DropdownItem> visitObjectList;
  final Zones zones;
  final List<DropdownItem> zonesList;
  final int zoneIndex;
  final UnitResponse units;
  final List<DropdownItem> unitList;
  final String date;
  final bool setUnits;
  final int currentUnitId;
  final List<String> selectedObj;
  final String taskNote;
  final UnitTypes unitType;
  final List<DropdownItem> unitTypeList;
  final int selectedUnitType;
  final Visitors visitors;
  final List<DropdownItem> visitorList;
  final bool setUnitType;
  final bool setVisitors;
  final int visitorId;
  final Forms forms;
  final bool loading;
  final bool objectiveLoading,
      assigneeLoading,
      zoneLoading,
      unitLoading,
      unitTypeLoading;

  AddNewEmergencyIssueState copyWith(
      {int? companyId,
      VisitObjectives? visitobjective,
      List<DropdownItem>? visitObjectList,
      List<DropdownItem>? zonesList,
      int? zoneIndex,
      UnitResponse? units,
      List<DropdownItem>? unitList,
      Zones? zones,
      String? date,
      bool? setUnits,
      bool? setUnitType,
      int? currentUnitId,
      List<String>? selectedObj,
      String? taskNote,
      UnitTypes? unitType,
      List<DropdownItem>? unitTypeList,
      int? selectedUnitType,
      Visitors? visitors,
      List<DropdownItem>? visitorList,
      bool? setVisitors,
      int? visitorId,
      Forms? forms,
      bool? loading,
      bool? objectiveLoading,
      bool? assigneeLoading,
      bool? zoneLoading,
      bool? unitLoading,
      bool? unitTypeLoading}) {
    return AddNewEmergencyIssueState(
        visitobjective: visitobjective ?? this.visitobjective,
        visitObjectList: visitObjectList ?? this.visitObjectList,
        companyId: companyId ?? this.companyId,
        zones: zones ?? this.zones,
        zonesList: zonesList ?? this.zonesList,
        zoneIndex: zoneIndex ?? this.zoneIndex,
        units: units ?? this.units,
        unitList: unitList ?? this.unitList,
        date: date ?? this.date,
        setUnits: setUnits ?? false,
        setUnitType: setUnitType ?? false,
        setVisitors: setVisitors ?? false,
        currentUnitId: currentUnitId ?? this.currentUnitId,
        selectedObj: selectedObj ?? this.selectedObj,
        taskNote: taskNote ?? this.taskNote,
        unitType: unitType ?? this.unitType,
        unitTypeList: unitTypeList ?? this.unitTypeList,
        selectedUnitType: selectedUnitType ?? this.selectedUnitType,
        visitors: visitors ?? this.visitors,
        visitorList: visitorList ?? this.visitorList,
        visitorId: visitorId ?? this.visitorId,
        forms: forms ?? this.forms,
        loading: loading ?? this.loading,
        objectiveLoading: objectiveLoading ?? this.objectiveLoading,
        assigneeLoading: assigneeLoading ?? this.assigneeLoading,
        zoneLoading: zoneLoading ?? this.zoneLoading,
        unitLoading: unitLoading ?? this.unitLoading,
        unitTypeLoading: unitTypeLoading ?? this.unitTypeLoading);
  }

  @override
  List<Object> get props => [
        visitobjective,
        visitObjectList,
        companyId,
        zones,
        zoneIndex,
        units,
        unitList,
        zonesList,
        date,
        setUnits,
        setUnitType,
        currentUnitId,
        selectedObj,
        taskNote,
        unitType,
        unitTypeList,
        selectedUnitType,
        visitors,
        visitorList,
        setVisitors,
        forms,
        visitorId,
        loading,
        objectiveLoading,
        assigneeLoading,
        zoneLoading,
        unitLoading,
        unitTypeLoading
      ];
}

class AddNewEmergencyIssueInitial extends AddNewEmergencyIssueState {}
