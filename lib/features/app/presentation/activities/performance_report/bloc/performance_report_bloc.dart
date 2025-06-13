import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/performance.dart';
import 'package:work_diary/features/app/data/models/user_id.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/entities/performance_report.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_visits/view/visitor_visits_screen.dart';

part 'performance_report_event.dart';
part 'performance_report_state.dart';

class PerformanceReportBloc
    extends Bloc<PerformanceReportEvent, PerformanceReportState> {
  PerformanceReportBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(VisitorDetailsInitial()) {
    on<GetDetailsById>(_getDetailsById);
    on<GetPerformance>(_getPerformance);
    on<GoToVisitorVisitsScreen>(_goToVisitorVisitsScreen);
    on<GoToDashboard>(_goToDashboard);
    on<SelectedMonth>(_selectedMonth);
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getDetailsById(
      GetDetailsById event, Emitter<PerformanceReportState> emit) async {
    List<DateTime> months = [];
    months.add(DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
    ));
    months.add(DateTime(DateTime.now().year, DateTime.now().month));
    months.add(DateTime(
      DateTime.now().year,
      DateTime.now().month + 1,
    ));

    List<DropdownItem> monthList = [];
    monthList.add(DropdownItem(
        name: "${DateFormat('MMM').format(months[0])} ${months[0].year}",
        value: 0));
    monthList.add(DropdownItem(
        name: "${DateFormat('MMM').format(months[1])} ${months[1].year}",
        value: 1));
    monthList.add(DropdownItem(
        name: "${DateFormat('MMM').format(months[2])} ${months[2].year}",
        value: 2));

    emit(state.copyWith(
        pageLoader: true,
        visitorDetails: event.visitorInfo,
        months: months,
        selectedMonth: 1,
        monthList: monthList));

    final visitor = await _apiRepo.post(
      endpoint: userProfileEndpoint,
      body: UserId(userId: event.visitorInfo.data!.id!, related: false),
      responseModel: const UserDetails(),
    );

    if (visitor != null) {
      emit(state.copyWith(visitorDetails: visitor));
    }

    add(GetPerformance());
  }

  FutureOr<void> _getPerformance(
      GetPerformance event, Emitter<PerformanceReportState> emit) async {
    emit(state.copyWith(pageLoader: true));

    final performance = await _apiRepo.post(
        endpoint: performanceEndpoint,
        body: Performance(
            companyId: await LocalData.getCompanyId(
                localStorageRepo: _localStorageRepo)!,
            userId: state.visitorDetails.data!.id!,
            month: state.months[state.selectedMonth].month,
            year: state.months[state.selectedMonth].year),
        responseModel: const PerformanceReport());
    emit(state.copyWith(pageLoader: false));

    if (performance != null) {
      emit(state.copyWith(performance: performance));
    }
  }

  FutureOr<void> _goToVisitorVisitsScreen(
      GoToVisitorVisitsScreen event, Emitter<PerformanceReportState> emit) {
    _iFlutterNavigator
        .push(VisitorVisitsScreen.route(userDetails: event.userDetails));
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<PerformanceReportState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  FutureOr<void> _selectedMonth(
      SelectedMonth event, Emitter<PerformanceReportState> emit) {
    emit(state.copyWith(selectedMonth: event.month));
    add(GetPerformance());
  }
}
