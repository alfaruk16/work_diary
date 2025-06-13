part of 'check_out_bloc.dart';

abstract class CheckOutState extends Equatable {
  const CheckOutState();
  
  @override
  List<Object> get props => [];
}

class CheckOutInitial extends CheckOutState {}
