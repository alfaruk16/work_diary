part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState(
      {this.username = '', this.loading = false, this.forms = Forms.initial});

  final String username;
  final bool loading;
  final Forms forms;

  ResetPasswordState copyWith({String? username, bool? loading, Forms? forms}) {
    return ResetPasswordState(
        username: username ?? this.username,
        loading: loading ?? this.loading,
        forms: forms ?? this.forms);
  }

  @override
  List<Object> get props => [username, loading, forms];
}

class ResetPasswordInitial extends ResetPasswordState {}
