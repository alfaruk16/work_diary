part of 'plan_details_bloc.dart';

class PlanDetailsState extends Equatable {
  const PlanDetailsState(
      {this.time = '',
      this.day = '',
      this.visitDetails = const PlanDetailsResponse(),
      this.page = 1,
      this.emergencyIssue = const EmergencyTaskResponse(),
      this.startedVisitList = const StartedVisitList(),
      this.loading = false,
      this.startLoading = false,
      this.cancelLoading = false});

  final String time, day;
  final PlanDetailsResponse visitDetails;
  final int page;
  final EmergencyTaskResponse emergencyIssue;

  final StartedVisitList startedVisitList;
  final bool loading, startLoading, cancelLoading;

  PlanDetailsState copyWith(
      {String? time,
      String? day,
        PlanDetailsResponse? visitDetails,
      int? page,
      EmergencyTaskResponse? emergencyIssue,
      StartedVisitList? startedVisitList,
      bool? loading,
      bool? startLoading,
      bool? cancelLoading}) {
    return PlanDetailsState(
        time: time ?? this.time,
        day: day ?? this.day,
        visitDetails: visitDetails ?? this.visitDetails,
        page: page ?? this.page,
        emergencyIssue: emergencyIssue ?? this.emergencyIssue,
        startedVisitList: startedVisitList ?? this.startedVisitList,
        loading: loading ?? this.loading,
        startLoading: startLoading ?? this.startLoading,
        cancelLoading: cancelLoading ?? this.cancelLoading);
  }

  @override
  List<Object> get props => [
        time,
        day,
        visitDetails,
        page,
        emergencyIssue,
        startedVisitList,
        loading,
        startLoading,
        cancelLoading
      ];
}

class StartCheckInVisitPlanInitial extends PlanDetailsState {}
