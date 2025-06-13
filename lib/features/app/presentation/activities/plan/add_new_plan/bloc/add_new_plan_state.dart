part of 'add_new_plan_bloc.dart';

class AddNewPlanState extends Equatable {
  const AddNewPlanState(
      {this.zones = const Zones(),
      this.zonesList = const [],
      this.zoneId = -1,
      this.areas = const Areas(),
      this.areaId = -1,
      this.areaList = const [],
      this.date = '',
      this.companyId = -1,
      this.setArea = false,
      this.visitNote = "",
      this.setVisitors = false,
      this.visitors = const Visitors(),
      this.visitorList = const [],
      this.visitorId = 0,
      this.forms = Forms.initial,
      this.loading = false,
      this.setZone = false,
      this.assigneeLoading = false,
      this.zoneLoading = false,
      this.areaLoading = false,
      this.userId = -1});

  final int companyId;
  final Zones zones;
  final List<DropdownItem> zonesList;
  final int zoneId;
  final Areas areas;
  final List<DropdownItem> areaList;
  final String date;
  final bool setArea;
  final int areaId;
  final String visitNote;
  final Visitors visitors;
  final List<DropdownItem> visitorList;
  final bool setVisitors;
  final int visitorId;
  final Forms forms;
  final bool loading;
  final bool setZone;
  final bool assigneeLoading, zoneLoading, areaLoading;
  final int userId;

  AddNewPlanState copyWith(
      {int? companyId,
      List<DropdownItem>? zonesList,
      int? zoneId,
      Areas? areas,
      List<DropdownItem>? areaList,
      Zones? zones,
      String? date,
      bool? setArea,
      int? areaId,
      String? visitNote,
      Visitors? visitors,
      List<DropdownItem>? visitorList,
      bool? setVisitors,
      int? visitorId,
      Forms? forms,
      bool? loading,
      String? unitMessage,
      bool? setZone,
      bool? assigneeLoading,
      bool? zoneLoading,
      bool? areaLoading,
      int? userId}) {
    return AddNewPlanState(
        companyId: companyId ?? this.companyId,
        zones: zones ?? this.zones,
        zonesList: zonesList ?? this.zonesList,
        zoneId: zoneId ?? this.zoneId,
        areas: areas ?? this.areas,
        areaId: areaId ?? this.areaId,
        areaList: areaList ?? this.areaList,
        date: date ?? this.date,
        setArea: setArea ?? false,
        setVisitors: setVisitors ?? false,
        visitNote: visitNote ?? this.visitNote,
        visitors: visitors ?? this.visitors,
        visitorList: visitorList ?? this.visitorList,
        visitorId: visitorId ?? this.visitorId,
        forms: forms ?? this.forms,
        loading: loading ?? this.loading,
        setZone: setZone ?? false,
        assigneeLoading: assigneeLoading ?? this.assigneeLoading,
        zoneLoading: zoneLoading ?? this.zoneLoading,
        areaLoading: areaLoading ?? this.areaLoading,
        userId: userId ?? this.userId);
  }

  @override
  List<Object> get props => [
        companyId,
        zones,
        zoneId,
        areas,
        areaId,
        areaList,
        zonesList,
        date,
        setArea,
        visitNote,
        visitors,
        visitorList,
        setVisitors,
        forms,
        visitorId,
        loading,
        setZone,
        assigneeLoading,
        zoneLoading,
        areaLoading,
        userId
      ];
}

class AddNewVisitPlanInitial extends AddNewPlanState {}
