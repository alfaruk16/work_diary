import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_visit_plan_details_event.dart';
part 'upcoming_visit_plan_details_state.dart';

class UpcomingVisitPlanDetailsBloc
    extends Bloc<UpcomingVisitPlanDetailsEvent, UpcomingVisitPlanDetailsState> {
  UpcomingVisitPlanDetailsBloc() : super(UpcomingVisitPlanDetailsInitial()) {
    on<UpcomingVisitPlanDetailsEvent>((event, emit) {});
  }
}
