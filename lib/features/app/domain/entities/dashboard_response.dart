import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class DashboardResponse {
  final Data? data;

  const DashboardResponse({
    this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final bool? areaPlan;
  final int? waitingForPlanApproval;
  final int? todaysPlan;
  final int? upcomingPlan;
  final VisitData? onGoing;
  final int? waitingForApproval;
  final EmergencyTaskForCurrentMonth? todaysVisit;
  final int? upcomingVisit;
  final EmergencyTaskForCurrentMonth? totalVisitForCurrentMonth;
  final EmergencyTaskForCurrentMonth? emergencyTaskForCurrentMonth;
  final int? visitorsCount;

  Data({
    this.areaPlan,
    this.waitingForPlanApproval,
    this.todaysPlan,
    this.upcomingPlan,
    this.onGoing,
    this.waitingForApproval,
    this.todaysVisit,
    this.upcomingVisit,
    this.totalVisitForCurrentMonth,
    this.emergencyTaskForCurrentMonth,
    this.visitorsCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        areaPlan: json["area_plan"],
        waitingForPlanApproval: json["waiting_for_plan_approval"],
        todaysPlan: json['todays_plan'],
        upcomingPlan: json["upcoming_plan"],
        onGoing: json["on_going"] != null
            ? VisitData.fromJson(json["on_going"])
            : null,
        waitingForApproval: json["waiting_for_approval"],
        todaysVisit: json["todays_visit"] == null
            ? null
            : EmergencyTaskForCurrentMonth.fromJson(json["todays_visit"]),
        upcomingVisit: json["upcoming_visit"],
        totalVisitForCurrentMonth: json["total_visit_for_current_month"] == null
            ? null
            : EmergencyTaskForCurrentMonth.fromJson(
                json["total_visit_for_current_month"]),
        emergencyTaskForCurrentMonth:
            json["emergency_task_for_current_month"] == null
                ? null
                : EmergencyTaskForCurrentMonth.fromJson(
                    json["emergency_task_for_current_month"]),
        visitorsCount: json["visitors_count"],
      );

  Map<String, dynamic> toJson() => {
        "area_plan": areaPlan,
        "waiting_for_plan_approval": waitingForPlanApproval,
        "todays_plan": todaysPlan,
        "upcoming_plan": upcomingPlan,
        "on_going": onGoing,
        "waiting_for_approval": waitingForApproval,
        "todays_visit": todaysVisit?.toJson(),
        "upcoming_visit": upcomingVisit,
        "total_visit_for_current_month": totalVisitForCurrentMonth?.toJson(),
        "emergency_task_for_current_month":
            emergencyTaskForCurrentMonth?.toJson(),
        "visitors_count": visitorsCount,
      };
}

class EmergencyTaskForCurrentMonth {
  final int? completed;
  final int? total;

  EmergencyTaskForCurrentMonth({
    this.completed,
    this.total,
  });

  factory EmergencyTaskForCurrentMonth.fromJson(Map<String, dynamic> json) =>
      EmergencyTaskForCurrentMonth(
        completed: json["completed"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "completed": completed,
        "total": total,
      };
}
