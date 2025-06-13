part of 'check_in_bloc.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();
  
  @override
  List<Object> get props => [];
}

class CheckInInitial extends CheckInState {}
