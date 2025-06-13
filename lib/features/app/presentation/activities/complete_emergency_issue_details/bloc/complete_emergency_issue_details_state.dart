part of 'complete_emergency_issue_details_bloc.dart';

class CompleteEmergencyIssueDetailsState extends Equatable {
  const CompleteEmergencyIssueDetailsState(
      {this.issueId = -1,
      this.companyId = -1,
      this.emergencyTaskDetails = const EmergencyTaskDetails(),
      this.loading = false});
  final int issueId;
  final int companyId;
  final EmergencyTaskDetails emergencyTaskDetails;
  final bool loading;

  CompleteEmergencyIssueDetailsState copyWith(
      {int? issueId,
      int? companyId,
      EmergencyTaskDetails? emergencyTaskDetails,
      bool? loading}) {
    return CompleteEmergencyIssueDetailsState(
        issueId: issueId ?? this.issueId,
        companyId: companyId ?? this.companyId,
        emergencyTaskDetails: emergencyTaskDetails ?? this.emergencyTaskDetails,
        loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [issueId, companyId, emergencyTaskDetails, loading];
}
