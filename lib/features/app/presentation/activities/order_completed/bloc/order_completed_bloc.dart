import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_completed_event.dart';
part 'order_completed_state.dart';

class OrderCompletedBloc
    extends Bloc<OrderCompletedEvent, OrderCompletedState> {
  OrderCompletedBloc() : super(OrderCompletedInitial()) {
    on<OrderCompletedEvent>((event, emit) {});
  }
}
