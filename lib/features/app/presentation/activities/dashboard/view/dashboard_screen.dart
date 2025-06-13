import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/nav_bar.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/view/for_me.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/view/supervisor.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/drawer.dart';
import 'package:work_diary/core/widgets/common_body.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const DashBoardScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(
          getIt<IFlutterNavigator>(),
          getIt<LocalStorageRepo>(),
          getIt<ApiRepo>(),
          getIt<ImagePicker>(),
          getIt<GetLocationRepo>()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Dashboard",
        back: false,
        drawer: DrawerViews(
            isCheckInEnable: state.isCheckInEnable,
            userDetails: state.userDetails),
        sidePadding: 0,
        onWillPop: false,
        loading: state.loading || state.chartLoading ? true : false,
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.userProfile.name,
            child: const TextB(text: "My Profile"),
            onTap: () {
              bloc.add(GoToUserProfileScreen());
            },
          ),
        ],
        bottomNav: NavBarB(
          items: [
            NavItem(
                name: 'Add Unit',
                icon: addUnitSvg,
                onTap: () {
                  bloc.add(GoToAddUnitScreen());
                }),
            NavItem(
                name: 'New Visit',
                icon: newVisitSvg,
                onTap: () {
                  bloc.add(GoToAddNewVisitScreen());
                }),
            NavItem(
                name: 'Add Emergency',
                icon: emergencyIssueLogoSvg,
                onTap: () {
                  bloc.add(GoToCreateEmergencyIssue());
                }),
          ],
          activeIndex: 1,
        ),
        child: state.isSuperVisor
            ? DefaultTabController(
                length: 2,
                initialIndex: state.selectedTab,
                child: Builder(builder: (BuildContext context) {
                  final tabController = DefaultTabController.of(context);
                  if (state.selectedTab != tabController.index) {
                    tabController.animateTo(state.selectedTab);
                  }
                  tabController.addListener(() {
                    bloc.add(TabChanged(index: tabController.index));
                  });
                  return Column(
                    children: [
                      TabBar(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        indicatorColor: bBlue,
                        labelColor: bBlue,
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
                      ),
                      const Expanded(
                        child: Material(
                          color: Colors.white,
                          child: TabBarView(
                            children: [
                              ForMeView(),
                              SupervisorView(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              )
            : const Material(color: Colors.white, child: ForMeView()),
      );
    });
  }
}
