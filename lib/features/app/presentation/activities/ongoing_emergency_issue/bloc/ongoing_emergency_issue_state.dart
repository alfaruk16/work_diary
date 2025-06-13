part of 'ongoing_emergency_issue_bloc.dart';

abstract class OngoingEmergencyIssueState extends Equatable {
  OngoingEmergencyIssueState();

  final noteController = TextEditingController();
  final noteFocusNode = FocusNode();
  
  @override
  List<Object> get props => [];
}

class OngoingEmergencyIssueInitial extends OngoingEmergencyIssueState {}
