class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

enum Forms { initial, submitted, inProgress, invalid, valid, success }

enum PopUpMenu {
  dashboard,
  userProfile,
  addNewEmergencyIssue,
  allEmergencyIssue,
  createNewVisitPlan,
  onGoingVisitPlan,
  allPlan,
  allVisitPlan,
  allUnit,
  createNewPlan
}

enum FormulaType { id, number, string, slot_field_id }

enum PlanListType {
  todayVisitPlan,
  totalVisitPlan,
  upcomingVisitPlan,
  upcomingThirty,
  yesterday,
  lastSeven,
  lastThirty,
  lastSixty,
  visitPlanFor
}

final Map<PlanListType, String> planListTypeValues = {
  PlanListType.todayVisitPlan: "Today's Visit Plan",
  PlanListType.totalVisitPlan: "Total Visit Plan",
  PlanListType.upcomingVisitPlan: "Upcoming Visit Plan",
  PlanListType.upcomingThirty: "Upcoming (Next 30 days)",
  PlanListType.yesterday: "Yesterday Visit Plan",
  PlanListType.lastThirty: "Last 30 Days Visit Plan",
  PlanListType.lastSixty: "Last 60 Days Visit Plan",
  PlanListType.visitPlanFor: "Visit Plan For",
};

enum Sync { initial, loading, success, failed }
