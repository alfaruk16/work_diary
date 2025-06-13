import 'package:equatable/equatable.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/core/utils/utils.dart';

class TodaysPlanStateOwn extends Equatable {
  const TodaysPlanStateOwn(
      {this.date = '',
      this.todayVisits = const TodaysVisitResponse(),
      this.visitStatus = const VisitStatus(),
      this.visitStatusList = const [DropdownItem(name: 'Filter by', value: -1)],
      this.selectedVisitStatus = '',
      this.selectedDate = -1,
      this.dateList = dateItemList,
      this.planListType = "Today's Visit Plan",
      this.page = 1,
      this.isLoading = false,
      this.isEndList = false,
      this.isSupervisor = false,
      this.userType = 'own',
      this.selectedTab = 0,
      this.selectedStatus = -1});

  final String date;
  final TodaysVisitResponse todayVisits;
  final VisitStatus visitStatus;
  final List<DropdownItem> visitStatusList;
  final String selectedVisitStatus;
  final int selectedDate;
  final List<DropdownItem> dateList;
  final String planListType;
  final int page;
  final bool isLoading, isEndList, isSupervisor;
  final String userType;
  final int selectedTab;
  final int selectedStatus;

  TodaysPlanStateOwn copyWith(
      {String? date,
      TodaysVisitResponse? todayVisits,
      Summery? summery,
      VisitStatus? visitStatus,
      List<DropdownItem>? visitStatusList,
      String? selectedVisitStatus,
      int? selectedDate,
      List<DropdownItem>? dateList,
      String? planListType,
      int? page,
      bool? isLoading,
      bool? isEndList,
      bool? isSupervisor,
      String? userType,
      int? selectedTab,
      int? selectedStatus}) {
    return TodaysPlanStateOwn(
        date: date ?? this.date,
        todayVisits: todayVisits ?? this.todayVisits,
        visitStatus: visitStatus ?? this.visitStatus,
        visitStatusList: visitStatusList ?? this.visitStatusList,
        selectedVisitStatus: selectedVisitStatus ?? this.selectedVisitStatus,
        selectedDate: selectedDate ?? this.selectedDate,
        dateList: dateList ?? this.dateList,
        planListType: planListType ?? this.planListType,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        isEndList: isEndList ?? this.isEndList,
        isSupervisor: isSupervisor ?? this.isSupervisor,
        userType: userType ?? this.userType,
        selectedTab: selectedTab ?? this.selectedTab,
        selectedStatus: selectedStatus ?? this.selectedStatus);
  }

  @override
  List<Object> get props => [
        date,
        todayVisits,
        visitStatus,
        visitStatusList,
        selectedVisitStatus,
        selectedDate,
        dateList,
        planListType,
        page,
        isLoading,
        isEndList,
        isSupervisor,
        userType,
        selectedTab,
        selectedStatus
      ];
}
