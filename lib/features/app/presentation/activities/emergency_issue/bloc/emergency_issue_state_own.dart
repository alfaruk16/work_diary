import 'package:equatable/equatable.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/domain/entities/emergency_task_response.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';

class EmergencyIssueStateOwn extends Equatable {
  const EmergencyIssueStateOwn(
      {this.date = '',
      this.emergencyIssue = const EmergencyTaskResponse(),
      this.visitStatus = const VisitStatus(),
      this.visitStatusList = const [DropdownItem(name: 'Filter by', value: -1)],
      this.selectedVisitStatus = '',
      this.selectedDate = 0,
      this.dateList = const [],
      this.listForDates = "Emergency Issue",
      this.page = 1,
      this.isLoading = false,
      this.isEndList = false,
      this.userType = 'own',
      this.incrementLoader = false});

  final String date;
  final EmergencyTaskResponse emergencyIssue;
  final VisitStatus visitStatus;
  final List<DropdownItem> visitStatusList;
  final String selectedVisitStatus;
  final int selectedDate;
  final List<DropdownItem> dateList;
  final String listForDates;
  final int page;
  final bool isLoading, isEndList;
  final String userType;
  final bool incrementLoader;

  EmergencyIssueStateOwn copyWith(
      {String? date,
      EmergencyTaskResponse? emergencyIssue,
      Summery? summery,
      VisitStatus? visitStatus,
      List<DropdownItem>? visitStatusList,
      String? selectedVisitStatus,
      int? selectedDate,
      List<DropdownItem>? dateList,
      String? listForDates,
      int? page,
      bool? isLoading,
      bool? isEndList,
      bool? incrementLoader}) {
    return EmergencyIssueStateOwn(
        date: date ?? this.date,
        emergencyIssue: emergencyIssue ?? this.emergencyIssue,
        visitStatus: visitStatus ?? this.visitStatus,
        visitStatusList: visitStatusList ?? this.visitStatusList,
        selectedVisitStatus: selectedVisitStatus ?? this.selectedVisitStatus,
        selectedDate: selectedDate ?? this.selectedDate,
        dateList: dateList ?? this.dateList,
        listForDates: listForDates ?? this.listForDates,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        isEndList: isEndList ?? this.isEndList,
        incrementLoader: incrementLoader ?? this.incrementLoader);
  }

  @override
  List<Object> get props => [
        date,
        emergencyIssue,
        visitStatus,
        visitStatusList,
        selectedVisitStatus,
        selectedDate,
        dateList,
        listForDates,
        page,
        isLoading,
        isEndList,
        incrementLoader
      ];
}

class EmergencyIssueInitial extends EmergencyIssueStateOwn {}
