part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfile extends UserProfileEvent {}

class PickImage extends UserProfileEvent {}

class EditPhoneEvent extends UserProfileEvent {
  const EditPhoneEvent({required this.ctx});
  final BuildContext ctx;
}

class GoToResetPasswordScreen extends UserProfileEvent {}

class UpdatePhone extends UserProfileEvent {
  const UpdatePhone({required this.number});
  final String number;
}

class GoToPerformance extends UserProfileEvent {}
