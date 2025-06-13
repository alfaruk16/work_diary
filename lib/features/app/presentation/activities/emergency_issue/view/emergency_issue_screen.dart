import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc_own.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc_supervisor.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/widgets/for_me_emergency.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/widgets/supervisor_emergency.dart';

class EmergencyIssueScreen extends StatelessWidget {
  const EmergencyIssueScreen({Key? key, this.selectedTab}) : super(key: key);
  final int? selectedTab;

  static Route<dynamic> route({int? selectedTab}) => MaterialPageRoute<dynamic>(
        builder: (_) => EmergencyIssueScreen(selectedTab: selectedTab),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EmergencyIssueBloc(
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
        ),
        BlocProvider(
            create: (_) => EmergencyIssueBlocOwn(getIt<IFlutterNavigator>(),
                getIt<ApiRepo>(), getIt<LocalStorageRepo>())),
        BlocProvider(
            create: (_) => EmergencyIssueBlocSupervisor(
                getIt<IFlutterNavigator>(),
                getIt<ApiRepo>(),
                getIt<LocalStorageRepo>())),
      ],
      child: EmergencyIssueView(
        selectedTab: selectedTab,
      ),
    );
  }
}

class EmergencyIssueView extends StatelessWidget {
  EmergencyIssueView({Key? key, this.selectedTab}) : super(key: key);
  final int? selectedTab;

  final dateController = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
  final dateFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EmergencyIssueBloc>();

    return BlocBuilder<EmergencyIssueBloc, EmergencyIssueState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: state.listForDates,
        sidePadding: 0,
        loading: state.isLoading,
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "Add New Emergency Issue"),
            onTap: () {
              bloc.add(MenuItemScreens(
                  name: PopUpMenu.addNewEmergencyIssue.name, context: context));
            },
          ),
          PopupMenuItem(
            value: PopUpMenu.allEmergencyIssue.name,
            child: const TextB(text: "All Emergency Issue"),
            onTap: () {
              bloc.add(MenuItemScreens(
                  name: PopUpMenu.allEmergencyIssue.name, context: context));
            },
          ),
          PopupMenuItem(
            value: PopUpMenu.dashboard.name,
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(MenuItemScreens(
                  name: PopUpMenu.dashboard.name, context: context));
            },
          )
        ],
        bottomSection: ButtonB(
          press: () {
            bloc.add(CreateEmergencyIssue(context: context));
          },
          text: "Create Emergency Issue",
          bgColor: bSkyBlue,
          textColor: bWhite,
        ),
        child: state.isSupervisor
            ? DefaultTabController(
                initialIndex: selectedTab ?? state.selectedTab,
                length: 2,
                child: Builder(builder: (BuildContext context) {
                  final tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    bloc.add(TabChanged(
                        selectedTab: tabController.index, context: context));
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
                          color: Colors.white,
                          child: TabBarView(
                            children: [
                              ForMeEmergency(
                                loaderStatus: (isLoading) {
                                  bloc.add(UpdateLoader(loading: isLoading));
                                },
                              ),
                              SupervisorEmergency(
                                loaderStatus: (isLoading) {
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
            : Material(
                color: Colors.white,
                child: ForMeEmergency(
                  loaderStatus: (isLoading) {
                    bloc.add(UpdateLoader(loading: isLoading));
                  },
                )),
      );
    });
  }
}
