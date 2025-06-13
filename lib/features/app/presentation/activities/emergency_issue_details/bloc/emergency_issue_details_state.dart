part of 'emergency_issue_details_bloc.dart';

class EmergencyIssueDetailsState extends Equatable {
  const EmergencyIssueDetailsState(
      {this.images = const [],
      this.issueId = -1,
      this.companyId = -1,
      this.emergencyTaskDetails = const EmergencyTaskDetails(),
      this.comments = "",
      this.lat = '',
      this.long = '',
      this.address = "Dhaka",
      this.loading = false,
      this.forms = Forms.initial});

  final List<ImageFile> images;
  final int issueId;
  final int companyId;
  final String lat;
  final String long;
  final String address;
  final EmergencyTaskDetails emergencyTaskDetails;
  final String comments;
  final bool loading;
  final Forms forms;

  EmergencyIssueDetailsState copyWith(
      {List<ImageFile>? images,
      int? issueId,
      int? companyId,
      EmergencyTaskDetails? emergencyTaskDetails,
      String? comments,
      String? lat,
      String? long,
      String? address,
      bool? loading,
      Forms? forms}) {
    return EmergencyIssueDetailsState(
        images: images ?? this.images,
        issueId: issueId ?? this.issueId,
        companyId: companyId ?? this.companyId,
        emergencyTaskDetails: emergencyTaskDetails ?? this.emergencyTaskDetails,
        comments: comments ?? this.comments,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        address: address ?? this.address,
        loading: loading ?? this.loading,
        forms: forms ?? this.forms);
  }

  @override
  List<Object> get props => [
        images,
        issueId,
        companyId,
        emergencyTaskDetails,
        comments,
        lat,
        long,
        address,
        loading,
        forms
      ];
}
