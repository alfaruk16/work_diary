import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/check_out_button.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/profile_header.dart';

class DrawerViews extends StatelessWidget {
  const DrawerViews(
      {Key? key,
      this.isCheckInEnable = false,
      this.userDetails = const UserDetails()})
      : super(key: key);

  final bool isCheckInEnable;
  final UserDetails userDetails;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      final bloc = context.read<DashboardBloc>();
      return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
            ),

            state.userDetails.data != null
                ? ProfileHeader(
                    press: () {
                      bloc.add(GoToUserProfileScreen());
                    },
                    image: state.userDetails.data!.avatar,
                    userName: state.userDetails.data!.name,
                    title:
                        "${state.userDetails.data!.designation!} (${state.userDetails.data!.company!.name})",
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
            if (isCheckInEnable) const SizedBox(height: 20),
            if (state.userDetails.data!.isCheckedIn!)
              Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextB(
                      text: state.userDetails.data!.isCheckedIn!
                          ? "checked in ${state.userDetails.data!.lastCheckedIn!}"
                          : '',
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            if (isCheckInEnable)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userDetails.data != null && !userDetails.data!.isCheckedIn!
                      ? CheckInButton(
                          press: () {
                            bloc.add(CheckIn());
                          },
                        )
                      : CheckOutButton(
                          press: () {
                            bloc.add(const CheckOut(attendance: true));
                          },
                        ),
                  const SizedBox(width: 10),
                  if (state.isCheckInLoading)
                    const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator())
                ],
              ),
            const SizedBox(height: 15),
            if (isCheckInEnable) const Divider(color: bGray),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerItem(
                      press: () {
                        bloc.add(GoToUserProfileScreen());
                      },
                      leftIcon: Icons.person,
                      name: "My Profile",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(GoToPerformance());
                      },
                      leftIcon: Icons.bubble_chart,
                      name: "My Performance Report",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(GoToAddNewVisitScreen());
                      },
                      leftIcon: Icons.add_circle_outline,
                      name: "New visit",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(const GoToTodaysVisitScreen(
                            selectedDateDropdown: 0));
                      },
                      leftIcon: Icons.tour,
                      name: "Today's visits",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(const GoToTodaysVisitScreen(
                            planListType: PlanListType.upcomingVisitPlan,
                            selectedDateDropdown: -1));
                      },
                      leftIcon: Icons.backup_table,
                      name: "Upcoming visits ",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(const GoToTodaysVisitScreen(
                            planListType: PlanListType.totalVisitPlan,
                            selectedDateDropdown: 3));
                      },
                      leftIcon: Icons.event_note_sharp,
                      name: "This Month's Visits",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(GoToEmergencyIssueScreen());
                      },
                      leftIcon: Icons.auto_fix_high,
                      name: "Emergency Issues",
                    ),
                    DrawerItem(
                      press: () {
                        bloc.add(GoToUnitListScreen());
                      },
                      leftIcon: Icons.add_business,
                      name: "Units",
                    ),
                    if (state.isSuperVisor)
                      DrawerItem(
                        press: () {
                          bloc.add(GoToVisitorListScreen());
                        },
                        leftIcon: Icons.group,
                        name: "My Team",
                      ),
                    // DrawerItem(
                    //   press: () {
                    //     bloc.add(Attendance());
                    //   },
                    //   leftIcon: Icons.domain_verification,
                    //   name: "Attendance",
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // const Spacer(),
            // Container(
            //     padding: const EdgeInsets.only(left: 20),
            //     child: InkWell(
            //       onTap: () {},
            //       child: Ink(
            //         padding: const EdgeInsets.symmetric(vertical: 8),
            //         child: const TextB(
            //           text: "Change password",
            //           fontColor: bBlack,
            //         ),
            //       ),
            //     )),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  bloc.add(LogOut());
                },
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const TextB(text: "Logout", fontColor: bBlack),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: TextB(
                    text: 'App Version : ${state.appVersion}', fontSize: 12)),
            const SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
