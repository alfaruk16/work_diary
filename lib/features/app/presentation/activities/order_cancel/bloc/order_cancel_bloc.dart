import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_cancel_event.dart';
part 'order_cancel_state.dart';

class OrderCancelBloc extends Bloc<OrderCancelEvent, OrderCancelState> {
  OrderCancelBloc() : super(OrderCancelInitial()) {
    on<OrderCancelEvent>((event, emit) {});
  }
}
