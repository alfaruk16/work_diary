import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/core/widgets/date_picker.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/chart_model.dart';
import 'package:work_diary/features/app/data/models/check_out.dart';
import 'package:work_diary/features/app/data/models/dashboard.dart';
import 'package:work_diary/features/app/data/models/limit.dart';
import 'package:work_diary/features/app/data/models/todo_list.dart';
import 'package:work_diary/features/app/domain/entities/chart_response.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/dashboard_response.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/user_profile.dart';
import 'package:work_diary/features/app/domain/entities/visit.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/features/app/domain/entities/visitors.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_emergency_issue/view/add_new_emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/view/add_new_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/add_unit/view/add_unit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/attendance/view/attendance_screen.dart';
import 'package:work_diary/features/app/presentation/activities/check_out/view/check_out_screen.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/previous_to_do_list.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/view/emergency_issue_screen.dart';
import 'package:work_diary/features/app/presentation/activities/login/view/log_in_screen.dart';
import 'package:work_diary/features/app/presentation/activities/notification/view/notification_screen.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/view/ongoing_visit_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/order_note/view/order_note_screen.dart';
import 'package:work_diary/features/app/presentation/activities/performance_report/view/performance_report_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan/view/add_new_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/view/add_new_plan_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/view/todays_plan_screen.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/view/todays_visit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/unit_list/view/unit_list_screen.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/view/user_profile.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_details/view/visitor_details_screen.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_list/view/visitor_list_screen.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._flutterNavigator, this._localStorageRepo, this._apiRepo,
      this._imagePicker, this._getLocationRepo)
      : super(const DashboardState()) {
    on<OpenDrawerEvent>(_openDrawer);
    on<CloseDrawerEvent>(_closeDrawer);
    on<GoToCheckOutScreen>(_goToCheckOutScreen);
    on<GoToUserProfileScreen>(_goToUserProfileScreen);
    on<GoToNotificationScreen>(_goToNotificationScreen);
    on<GoToAddNewVisitScreen>(_goToAddNewVisitScreen);
    on<GoToAddUnitScreen>(_goToAddUnitScreen);
    on<GoToTodaysVisitScreen>(_goToTodaysVisitPlanScreen);
    on<GoToEmergencyIssueScreen>(_goToEmergencyIssueScreen);
    on<GoToUnitListScreen>(_goToUnitListScreen);
    on<GoToOrderNoteScreen>(_goToOrderNoteScreen);
    on<GoToAttendanceScreen>(_goToAttendanceScreen);
    on<GoToOnGoingVisitPlanScreen>(_goToOnGoingVisitPlan);
    on<GoToVisitorListScreen>(_goToVisitorListScreen);
    on<GetUserProfileEvent>(_getUserProfileEvent);
    on<TabChanged>(_tabChanged);
    on<GetDashboardData>(_getDashboardData);
    on<Notifications>(_notifications);
    on<Attendance>(_attendance);
    on<OrderNote>(_orderNote);
    on<LogOut>(_logOut);
    on<GetChart>(_getChart);
    on<GetPreviousToDoList>(_getPreviousToDoList);
    on<ShowPreviousVisitModal>(_showPreviousVisitModal);
    on<SelectDate>(_selectDate);
    on<SwitchEvent>(_switchEvent);
    on<UpdateTodoList>(_updateTodoList);
    on<CheckLocal>(_checkLocal);
    on<GoToCreateEmergencyIssue>(_createEmergencyIssue);
    on<GetVisitors>(_getVisitors);
    on<GoToVisitorDetails>(_goToVisitorDetails);
    on<ReviewApp>(_reviewApp);
    on<GetAppVersion>(_getAppVersion);
    on<GoToTodayPlanScreen>(_goToTodayPlanScreen);
    on<GoToAddNewPlanScreen>(_goToAddNewPlanScreen);
    on<HasAreaPlan>(_hasAreaPlan);
    on<CheckVisitStatus>(_checkVisitStatus);
    on<AssignToNewVisit>(_assignToNewVisit);
    on<IsCheckInEnabled>(_isCheckInEnabled);
    on<CheckIn>(_checkIn);
    on<CheckOut>(_checkOut);
    on<CheckProfile>(_checkProfile);
    on<CheckPreviousAttendanceIsTrue>(_checkPreviousAttendanceIsTrue);
    on<GoToPerformance>(_goToPerformanceReport);

    add(CheckProfile());
    add(GetChart(selectedTab: state.selectedTab));
    add(GetDashboardData(selectedTab: state.selectedTab));
    add(GetPreviousToDoList());
    add(CheckLocal());
    add(GetVisitors());
    add(ReviewApp());
    add(GetAppVersion());
    add(HasAreaPlan());
    add(CheckVisitStatus());
    add(IsCheckInEnabled());
  }

  final IFlutterNavigator _flutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final ApiRepo _apiRepo;
  final ImagePicker _imagePicker;
  final GetLocationRepo _getLocationRepo;

  FutureOr<void> _openDrawer(
      OpenDrawerEvent event, Emitter<DashboardState> emit) {
    Scaffold.of(event.context).openDrawer();
  }

  FutureOr<void> _closeDrawer(
      CloseDrawerEvent event, Emitter<DashboardState> emit) {
    Scaffold.of(event.context).closeDrawer();
  }

  FutureOr<void> _goToCheckOutScreen(
      GoToCheckOutScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator.push(CheckOutScreen.route());
  }

  FutureOr<void> _goToUserProfileScreen(
      GoToUserProfileScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator
        .push(UserProfileScreen.route())
        .then((value) => add(GetUserProfileEvent()));
  }

  FutureOr<void> _goToNotificationScreen(
      GoToNotificationScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator.push(NotificationScreen.route());
  }

  FutureOr<void> _goToAddNewVisitScreen(
      GoToAddNewVisitScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }

    if (state.hasAreaPlan) {
      _flutterNavigator.push(AddNewPlanVisitScreen.route()).then((value) async {
        await Future.delayed(const Duration(milliseconds: 100));
        if (value != null) {
          final visitData = value as VisitData;
          if (visitData.forOwn! && state.selectedTab != 0) {
            add(const TabChanged(index: 0));
          } else if (!visitData.forOwn! && state.selectedTab != 1) {
            add(const TabChanged(index: 1));
          }
          add(GetDashboardData(selectedTab: state.selectedTab));
          add(GetChart(selectedTab: state.selectedTab));
        }
      });
    } else {
      _flutterNavigator.push(AddNewVisitScreen.route()).then((value) async {
        if (value != null) {
          await Future.delayed(const Duration(milliseconds: 100));
          final visitData = value as VisitData;
          if (visitData.forOwn! && state.selectedTab != 0) {
            add(const TabChanged(index: 0));
          } else if (!visitData.forOwn! && state.selectedTab != 1) {
            add(const TabChanged(index: 1));
          }
          add(GetDashboardData(selectedTab: state.selectedTab));
          add(GetChart(selectedTab: state.selectedTab));
        }
      });
    }
  }

  FutureOr<void> _goToAddUnitScreen(
      GoToAddUnitScreen event, Emitter<DashboardState> emit) {
    _flutterNavigator.push(AddUnitScreen.route()).then((value) {
      add(GetDashboardData(selectedTab: state.selectedTab));
      add(GetChart(selectedTab: state.selectedTab));
    });
  }

  FutureOr<void> _goToTodaysVisitPlanScreen(
      GoToTodaysVisitScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator
        .push(TodaysVisitScreen.route(
            planType: event.planListType,
            selectedTab: state.selectedTab,
            selectedDateDropdown: event.selectedDateDropdown,
            selectedStatus: event.selectedStatusDropdown))
        .then((value) {
      add(GetChart(selectedTab: state.selectedTab));
      add(GetDashboardData(selectedTab: state.selectedTab));
    });
  }

  FutureOr<void> _goToEmergencyIssueScreen(
      GoToEmergencyIssueScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator
        .push(EmergencyIssueScreen.route(selectedTab: state.selectedTab))
        .then((value) => add(GetDashboardData(selectedTab: state.selectedTab)));
  }

  FutureOr<void> _goToOrderNoteScreen(
      GoToOrderNoteScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator.push(OrderNoteScreen.route());
  }

  FutureOr<void> _goToAttendanceScreen(
      GoToAttendanceScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator.push(AttendanceScreen.route());
  }

  FutureOr<void> _goToOnGoingVisitPlan(
      GoToOnGoingVisitPlanScreen event, Emitter<DashboardState> emit) {
    _flutterNavigator
        .push(OngoingVisitPlanScreen.route(visitData: event.visitData))
        .then((value) {
      add(GetChart(selectedTab: state.selectedTab));
      add(GetDashboardData(selectedTab: state.selectedTab));
    });
  }

  Future<FutureOr<void>> _checkProfile(
      CheckProfile event, Emitter<DashboardState> emit) async {
    final userProfile = await _localStorageRepo.readModel(
        key: userProfileDB, model: const UserDetails());
    if (userProfile != null) {
      emit(state.copyWith(
          userDetails: userProfile,
          isSuperVisor: userProfile.data!.isSupervisor));
    } else {
      add(GetUserProfileEvent());
    }
  }

  FutureOr<void> _getUserProfileEvent(
      GetUserProfileEvent event, Emitter<DashboardState> emit) async {
    final userProfileData = await _apiRepo.post(
        endpoint: userProfileEndpoint, responseModel: const UserDetails());

    if (userProfileData != null) {
      emit(state.copyWith(
          userDetails: userProfileData,
          isSuperVisor: userProfileData.data!.isSupervisor));
      _localStorageRepo.writeModel(key: userProfileDB, value: userProfileData);
    }
  }

  FutureOr<void> _tabChanged(TabChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedTab: event.index));
    add(GetChart(selectedTab: event.index));
    add(GetDashboardData(selectedTab: event.index));
  }

  FutureOr<void> _getDashboardData(
      GetDashboardData event, Emitter<DashboardState> emit) async {
    if (!state.loading) {
      emit(state.copyWith(loading: true));

      final dashboardResponse = await _apiRepo.post(
        endpoint: dashboardGetEndpoint,
        body: Dashboard(
            dashboardFor: event.selectedTab == 0 ? "own" : "as_supervisor"),
        responseModel: const DashboardResponse(),
      );

      if (dashboardResponse != null) {
        if (event.selectedTab == 0) {
          emit(state.copyWith(dashboard: dashboardResponse));
          _localStorageRepo.writeModel(
              key: dashboardOwnDB, value: dashboardResponse);
        } else {
          emit(state.copyWith(dashboardSupervisor: dashboardResponse));
          _localStorageRepo.writeModel(
              key: dashboardSupervisorDB, value: dashboardResponse);
        }
      }
      emit(state.copyWith(loading: false));
      if (event.selectedTab == 1) {
        add(GetVisitors());
      }
    }
  }

  FutureOr<void> _attendance(Attendance event, Emitter<DashboardState> emit) {
    _flutterNavigator.pop();
    _flutterNavigator.push(AttendanceScreen.route());
  }

  FutureOr<void> _notifications(
      Notifications event, Emitter<DashboardState> emit) {
    _flutterNavigator.pop();
    _flutterNavigator.push(NotificationScreen.route());
  }

  FutureOr<void> _orderNote(OrderNote event, Emitter<DashboardState> emit) {
    _flutterNavigator.pop();
    _flutterNavigator.push(OrderNoteScreen.route());
  }

  Future<FutureOr<void>> _logOut(
      LogOut event, Emitter<DashboardState> emit) async {
    final response = await _apiRepo.post(
        endpoint: logOutEndpoint, responseModel: const DefaultResponse());
    if (response != null) {
      _localStorageRepo.removeAll();
      _flutterNavigator.pushReplacement(LogInScreen.route());
    }
  }

  FutureOr<void> _getChart(GetChart event, Emitter<DashboardState> emit) async {
    if (!state.chartLoading) {
      emit(state.copyWith(chartLoading: true));

      final chartResponse = await _apiRepo.post(
        endpoint: dashboardChartGetEndpoint,
        body: ChartModel(
          chartFor: event.selectedTab == 0 ? "own" : "as_supervisor",
        ),
        responseModel: const ChartResponse(),
      );

      if (chartResponse != null) {
        if (event.selectedTab == 0) {
          emit(state.copyWith(chartData: chartResponse));
          _localStorageRepo.writeModel(
              key: dashboardChartOwnDB, value: chartResponse);
        } else {
          emit(state.copyWith(chartDataSuperVisor: chartResponse));
          _localStorageRepo.writeModel(
              key: dashboardChartSupervisorDB, value: chartResponse);
        }
      }
      emit(state.copyWith(chartLoading: false));
    }
  }

  FutureOr<void> _getPreviousToDoList(
      GetPreviousToDoList event, Emitter<DashboardState> emit) async {
    final todoUpdateDate = _localStorageRepo.read(key: todoUpdateDateDB);

    if (todoUpdateDate == null ||
        todoUpdateDate != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      final List<ToDoVisit> list = [];
      final listResponse = await _apiRepo.post(
          endpoint: previousToDoListEndpoint, responseModel: const Visits());

      if (listResponse != null) {
        if (listResponse.data != null && listResponse.data!.isNotEmpty) {
          for (int i = 0; i < listResponse.data!.length; i++) {
            list.add(
              ToDoVisit(
                id: listResponse.data![i].id!,
                status: "extended",
                dateFor: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              ),
            );
          }
          emit(state.copyWith(
            previousToDoList: listResponse,
            toDoList: ToDoList(visits: list),
          ));
          if (state.toDoList.visits!.isNotEmpty) {
            add(ShowPreviousVisitModal());
          }
        } else {
          _localStorageRepo.write(
              key: todoUpdateDateDB,
              value: DateFormat('yyyy-MM-dd').format(DateTime.now()));
        }
      }
      add(CheckPreviousAttendanceIsTrue());
    }
  }

  FutureOr<void> _showPreviousVisitModal(
      ShowPreviousVisitModal event, Emitter<DashboardState> emit) {
    previousToDoList(
      _flutterNavigator.context,
      tododVisits: state.previousToDoList,
      loading: state.updateTodoLoading,
      pressSwitch: (bool value, int index) {
        add(SwitchEvent(isContinue: value, index: index));
      },
      press: (int index, TextEditingController dateController) {
        if (state.toDoList.visits![index].status == "extended") {
          datePicker(
            _flutterNavigator.context,
            minDate: DateTime.now(),
            date: (date) {
              add(SelectDate(
                  index: index,
                  date: date.toString(),
                  dateController: dateController));
            },
          );
        }
      },
      confirmStart: () {
        add(UpdateTodoList());
      },
    );
  }

  FutureOr<void> _selectDate(SelectDate event, Emitter<DashboardState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(event.date));
    event.dateController.text = date;
    final list = state.toDoList.visits;
    list![event.index].dateFor = date;
    list[event.index].status = "extended";
    emit(state.copyWith(toDoList: ToDoList(visits: list)));
  }

  FutureOr<void> _switchEvent(SwitchEvent event, Emitter<DashboardState> emit) {
    final list = state.toDoList.visits;
    list![event.index].status = event.isContinue ? 'extended' : 'skip';
    emit(state.copyWith(toDoList: ToDoList(visits: list)));
  }

  FutureOr<void> _updateTodoList(
      UpdateTodoList event, Emitter<DashboardState> emit) async {
    if (!state.updateTodoLoading) {
      emit(state.copyWith(updateTodoLoading: true));
      _localStorageRepo.remove(key: todoUpdateDateDB);

      final updateTodo = await _apiRepo.post(
        endpoint: visitsPreviousTodoListUpdate,
        body: ToDoList(visits: state.toDoList.visits),
        responseModel: const Visits(),
      );

      if (updateTodo == null || updateTodo.data!.isEmpty) {
        _flutterNavigator.pop();
        add(GetChart(selectedTab: state.selectedTab));
        add(GetDashboardData(selectedTab: state.selectedTab));
        _localStorageRepo.write(
            key: todoUpdateDateDB,
            value: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      }
      emit(state.copyWith(updateTodoLoading: false));
    }
  }

  FutureOr<void> _checkLocal(
      CheckLocal event, Emitter<DashboardState> emit) async {
    final dashboardData = await _localStorageRepo.readModel(
        key: dashboardOwnDB, model: const DashboardResponse());
    if (dashboardData != null) {
      emit(state.copyWith(dashboard: dashboardData));
    }

    final dashboardDataSupervisor = await _localStorageRepo.readModel(
        key: dashboardSupervisorDB, model: const DashboardResponse());

    if (dashboardDataSupervisor != null) {
      emit(state.copyWith(dashboardSupervisor: dashboardDataSupervisor));
    }

    final dashboardChartData = await _localStorageRepo.readModel(
        key: dashboardChartOwnDB, model: const ChartResponse());
    if (dashboardChartData != null) {
      emit(state.copyWith(chartData: dashboardChartData));
    }

    final dashboardDataChartSupervisor = await _localStorageRepo.readModel(
        key: dashboardChartSupervisorDB, model: const ChartResponse());

    if (dashboardDataChartSupervisor != null) {
      emit(state.copyWith(chartDataSuperVisor: dashboardDataChartSupervisor));
    }
  }

  FutureOr<void> _goToUnitListScreen(
      GoToUnitListScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator.push(UnitListScreen.route()).then((value) {
      add(GetDashboardData(selectedTab: state.selectedTab));
      add(GetChart(selectedTab: state.selectedTab));
    });
  }

  FutureOr<void> _createEmergencyIssue(
      GoToCreateEmergencyIssue event, Emitter<DashboardState> emit) {
    _flutterNavigator.push(AddNewEmergencyIssueScreen.route()).then((value) {
      add(GetDashboardData(selectedTab: state.selectedTab));
      add(GetChart(selectedTab: state.selectedTab));
    });
  }

  FutureOr<void> _getVisitors(
      GetVisitors event, Emitter<DashboardState> emit) async {
    final visitorsData = await _localStorageRepo.readModel(
        key: dashboardVisitorsDB, model: const Visitors());

    if (visitorsData != null) {
      emit(state.copyWith(visitors: visitorsData));
    }

    final visitors = await _apiRepo.post(
        body: Limit(limit: 3), //this limit for dashboard
        endpoint: usersGetVisitorsEndpoint,
        responseModel: const Visitors());

    if (visitors != null) {
      emit(state.copyWith(visitors: visitors));
      _localStorageRepo.writeModel(key: dashboardVisitorsDB, value: visitors);
    }
  }

  FutureOr<void> _goToVisitorDetails(
      GoToVisitorDetails event, Emitter<DashboardState> emit) {
    _flutterNavigator.push(VisitorDetailsScreen.route(visitor: event.visitor));
  }

  FutureOr<void> _goToVisitorListScreen(
      GoToVisitorListScreen event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) {
      _flutterNavigator.pop();
    }
    _flutterNavigator.push(VisitorListScreen.route());
  }

  FutureOr<void> _reviewApp(
      ReviewApp event, Emitter<DashboardState> emit) async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  Future<FutureOr<void>> _getAppVersion(
      GetAppVersion event, Emitter<DashboardState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(appVersion: packageInfo.version));
  }

  FutureOr<void> _goToTodayPlanScreen(
      GoToTodayPlanScreen event, Emitter<DashboardState> emit) {
    _flutterNavigator
        .push(TodaysPlanScreen.route(
            planType: event.planListType,
            selectedTab: state.selectedTab,
            selectedDateDropdown: event.selectedDateDropdown,
            selectedStatus: event.selectedStatusDropdown))
        .then((value) {
      add(GetChart(selectedTab: state.selectedTab));
      add(GetDashboardData(selectedTab: state.selectedTab));
    });
  }

  FutureOr<void> _goToAddNewPlanScreen(
      GoToAddNewPlanScreen event, Emitter<DashboardState> emit) {
    _flutterNavigator.push(AddNewPlanScreen.route()).then((value) async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (value != null) {
        final visitData = value as VisitData;
        if (visitData.forOwn! && state.selectedTab != 0) {
          add(const TabChanged(index: 0));
        } else if (!visitData.forOwn! && state.selectedTab != 1) {
          add(const TabChanged(index: 1));
        }
      }
    });
  }

  Future<FutureOr<void>> _hasAreaPlan(
      HasAreaPlan event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(
        hasAreaPlan:
            await LocalData.hasAreaPlan(localStorageRepo: _localStorageRepo)));
  }

  Future<FutureOr<void>> _checkVisitStatus(
      CheckVisitStatus event, Emitter<DashboardState> emit) async {
    final visitStatusData = await _localStorageRepo.readModel(
        key: planStatusDB, model: const VisitStatus());

    if (visitStatusData == null) {
      final visitStatusResponse = await _apiRepo.post(
          endpoint: getPlanStatusEndpoint, responseModel: const VisitStatus());
      if (visitStatusResponse != null) {
        _localStorageRepo.writeModel(
            key: planStatusDB, value: visitStatusResponse);
      }
    }
  }

  Future<FutureOr<void>> _assignToNewVisit(
      AssignToNewVisit event, Emitter<DashboardState> emit) async {
    if (await LocalData.hasAreaPlan(localStorageRepo: _localStorageRepo)) {
      _flutterNavigator
          .push(AddNewPlanScreen.route(visitorId: event.visitorId));
    } else {
      _flutterNavigator
          .push(AddNewVisitScreen.route(visitorId: event.visitorId));
    }
  }

  FutureOr<void> _isCheckInEnabled(
      IsCheckInEnabled event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(
        isCheckInEnable: await LocalData.isCheckInEnabled(
            localStorageRepo: _localStorageRepo)));
  }

  Future<FutureOr<void>> _checkIn(
      CheckIn event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isCheckInLoading: true));
    XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);

    if (file != null) {
      final locationData = await _getLocationRepo.getLocation();

      if (locationData != null) {
        final address = await _getLocationRepo.getAddress(
            lat: locationData.latitude!, lng: locationData.longitude!);

        if (address != null) {
          Map<String, String> body = {
            "lat": locationData.latitude.toString(),
            "long": locationData.longitude.toString(),
            "address": address,
          };

          final checkIn = await _apiRepo.multipart(
            endpoint: checkInEndpoint,
            body: body,
            files: [ImageFile(name: 'image', file: file)],
            responseModel: const DefaultResponse(),
          );

          emit(state.copyWith(isCheckInLoading: false));
          if (checkIn != null) {
            ShowSnackBar(
                message: checkIn.message!, navigator: _flutterNavigator);
            add(GetUserProfileEvent());
          }
          if (_flutterNavigator.canPop() && !isClosed) {
            _flutterNavigator.pop();
          }
        } else {
          emit(state.copyWith(isCheckInLoading: false));
          if (_flutterNavigator.canPop() && !isClosed) {
            _flutterNavigator.pop();
          }
          ShowSnackBar(
              message: 'Location Not Found, Please Try Again',
              navigator: _flutterNavigator,
              color: Colors.black);
        }
      } else {
        emit(state.copyWith(isCheckInLoading: false));
        if (_flutterNavigator.canPop() && !isClosed) {
          _flutterNavigator.pop();
        }
        ShowSnackBar(
            message: 'Location Not Found, Please Try Again',
            navigator: _flutterNavigator,
            color: Colors.black);
      }
    }
  }

  Future<FutureOr<void>> _checkOut(
      CheckOut event, Emitter<DashboardState> emit) async {
    if (event.attendance) {
      emit(state.copyWith(isCheckInLoading: true));

      final locationData = await _getLocationRepo.getLocation();

      if (locationData != null) {
        final address = await _getLocationRepo.getAddress(
            lat: locationData.latitude!, lng: locationData.longitude!);

        if (address != null) {
          final checkOut = await _apiRepo.post(
            endpoint: checkOutEndpoint,
            body: CheckOutModel(
                lat: locationData.latitude!,
                long: locationData.longitude!,
                address: address,
                attendance: event.attendance),
            responseModel: const DefaultResponse(),
          );

          emit(state.copyWith(isCheckInLoading: false));
          if (checkOut != null) {
            ShowSnackBar(
                message: checkOut.message!, navigator: _flutterNavigator);
            add(GetUserProfileEvent());
          }
          if (_flutterNavigator.canPop() && !isClosed) {
            _flutterNavigator.pop();
          }
        } else {
          emit(state.copyWith(isCheckInLoading: false));
          if (_flutterNavigator.canPop() && !isClosed) {
            _flutterNavigator.pop();
          }
          ShowSnackBar(
              message: 'Location Not Found, Please Try Again',
              navigator: _flutterNavigator,
              color: Colors.black);
        }
      } else {
        emit(state.copyWith(isCheckInLoading: false));
        if (_flutterNavigator.canPop() && !isClosed) {
          _flutterNavigator.pop();
        }
        ShowSnackBar(
            message: 'Location Not Found, Please Try Again',
            navigator: _flutterNavigator,
            color: Colors.black);
      }
    } else {
      final checkOut = await _apiRepo.post(
          endpoint: checkOutEndpoint,
          body: CheckOutModel(attendance: event.attendance),
          responseModel: const DefaultResponse());
      if (checkOut != null) {
        add(GetUserProfileEvent());
      }
    }
  }

  FutureOr<void> _checkPreviousAttendanceIsTrue(
      CheckPreviousAttendanceIsTrue event, Emitter<DashboardState> emit) async {
    if (await LocalData.isCheckInEnabled(localStorageRepo: _localStorageRepo)) {
      final user = await _localStorageRepo.readModel(
          key: userProfileDB, model: const UserDetails());
      if (user != null && user.data!.isCheckedIn!) {
        add(const CheckOut(attendance: false));
      }
    }
  }

  FutureOr<void> _goToPerformanceReport(
      GoToPerformance event, Emitter<DashboardState> emit) {
    if (_flutterNavigator.canPop()) _flutterNavigator.pop();
    _flutterNavigator
        .push(PerformanceReportScreen.route(visitor: state.userDetails));
  }
}
