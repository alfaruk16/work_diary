part of 'emergency_issue_cancelled_bloc.dart';

class EmergencyIssueCancelledState extends Equatable {
  const EmergencyIssueCancelledState(
      {this.emergencyTaskDetails = const EmergencyTaskDetails(),
      this.loading = false});

  final EmergencyTaskDetails emergencyTaskDetails;
  final bool loading;

  EmergencyIssueCancelledState copyWith(
      {EmergencyTaskDetails? emergencyTaskDetails, bool? loading}) {
    return EmergencyIssueCancelledState(
        emergencyTaskDetails: emergencyTaskDetails ?? this.emergencyTaskDetails,
        loading: loading ?? this.loading);
  }

  @override
  List<Object> get props => [emergencyTaskDetails, loading];
}
