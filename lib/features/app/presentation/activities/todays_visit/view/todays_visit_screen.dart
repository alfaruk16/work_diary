import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/today_visit_own_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/today_visit_supervisor_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/widget/today_own.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/widget/today_supervisor.dart';

class TodaysVisitScreen extends StatelessWidget {
  const TodaysVisitScreen(
      {Key? key,
      this.planListType,
      this.selectedTab,
      this.selectedDateDropdown,
      this.status})
      : super(key: key);

  final PlanListType? planListType;
  final int? selectedTab;
  final int? selectedDateDropdown;
  final String? status;

  static Route<dynamic> route(
          {PlanListType? planType,
          int? selectedTab,
          int? selectedDateDropdown,
          String? selectedStatus}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => TodaysVisitScreen(
          planListType: planType,
          selectedTab: selectedTab,
          selectedDateDropdown: selectedDateDropdown,
          status: selectedStatus,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => TodaysVisitBloc(
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
                ..add(SetPlanListType(
                    planListType: planListType, selectedTab: selectedTab))),
          BlocProvider(
              create: (_) => TodaysVisitBlocOwn(getIt<IFlutterNavigator>(),
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>())
                ..add(SetPlanListType(
                    planListType: planListType,
                    selectedTab: selectedTab,
                    selectedDateDropdown: selectedDateDropdown,
                    status: status))),
          BlocProvider(
              create: (_) => TodaysVisitBlocSupervisor(
                  getIt<IFlutterNavigator>(),
                  getIt<ApiRepo>(),
                  getIt<LocalStorageRepo>())
                ..add(SetPlanListType(
                    planListType: planListType,
                    selectedTab: selectedTab,
                    selectedDateDropdown: selectedDateDropdown,
                    status: status))),
        ],
        child: TodaysVisitView(
            selectedTab: selectedTab,
            selectedDateDropdown: selectedDateDropdown));
  }
}

class TodaysVisitView extends StatelessWidget {
  const TodaysVisitView({Key? key, this.selectedTab, this.selectedDateDropdown})
      : super(key: key);

  final int? selectedTab;
  final int? selectedDateDropdown;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodaysVisitBloc>();
    int? tabIndex = selectedTab;

    return BlocBuilder<TodaysVisitBloc, TodaysVisitState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: 'Visits',
        sidePadding: 0,
        loading: state.isLoading,
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "New Visit"),
            onTap: () {
              bloc.add(MenuItemScreens(
                  name: PopUpMenu.createNewVisitPlan.name, context: context));
            },
          ),
          PopupMenuItem(
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(MenuItemScreens(
                  name: PopUpMenu.dashboard.name, context: context));
            },
          )
        ],
        child: state.isSupervisor
            ? DefaultTabController(
                initialIndex: tabIndex ?? state.selectedTab,
                length: 2,
                child: Builder(builder: (BuildContext context) {
                  final tabController = DefaultTabController.of(context);
                  if (tabIndex == null) {
                    tabController.animateTo(state.selectedTab);
                  }
                  tabIndex = null;
                  tabController.addListener(() {
                    bloc.add(TabChanged(
                        index: tabController.index, context: context));
                  });
                  return Column(
                    children: [
                      Container(
                          height: 36,
                          color: bWhiteGray,
                          child: TabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            indicatorColor: bBlue.withOpacity(.7),
                            labelColor: bBlue.withOpacity(.8),
                            unselectedLabelColor: bGray,
                            onTap: (val) {},
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.how_to_reg),
                                    SizedBox(width: 5),
                                    Text('Own'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.supervisor_account_outlined),
                                    SizedBox(width: 5),
                                    Text('Supervisor'),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Material(
                          child: TabBarView(
                            children: [
                              TodayOwn(
                                loadingStatus: (isLoading) {
                                  bloc.add(UpdateLoader(loading: isLoading));
                                },
                              ),
                              TodaySupervisor(
                                loadingStatus: (isLoading) {
                                  bloc.add(UpdateLoader(loading: isLoading));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              )
            : TodayOwn(
                loadingStatus: (isLoading) {
                  bloc.add(UpdateLoader(loading: isLoading));
                },
              ),
      );
    });
  }
}
