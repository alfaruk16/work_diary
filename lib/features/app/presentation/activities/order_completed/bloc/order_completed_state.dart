part of 'order_completed_bloc.dart';

abstract class OrderCompletedState extends Equatable {
  const OrderCompletedState();
  
  @override
  List<Object> get props => [];
}

class OrderCompletedInitial extends OrderCompletedState {}
