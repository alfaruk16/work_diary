part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({
    this.userDetails = const UserDetails(),
    this.attachments = const [],
  });

  final UserDetails userDetails;
  final List<ImageFile> attachments;

  UserProfileState copyWith(
      {UserDetails? userDetails, List<ImageFile>? attachments}) {
    return UserProfileState(
        userDetails: userDetails ?? this.userDetails,
        attachments: attachments ?? this.attachments);
  }

  @override
  List<Object> get props => [userDetails, attachments];
}

class UserProfileInitial extends UserProfileState {}
