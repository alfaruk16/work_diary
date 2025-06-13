import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadedNotificationEvent>(_loadedNotifications);
  }

  //final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _loadedNotifications(LoadedNotificationEvent event, Emitter<NotificationState> emit) {
    emit(LoadedNotification());
  }
}
