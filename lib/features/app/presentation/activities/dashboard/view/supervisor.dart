import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/bar_chart.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/plan.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/status_card_h.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/team.dart';

class SupervisorView extends StatelessWidget {
  const SupervisorView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(const GetChart(selectedTab: 1));
              bloc.add(const GetDashboardData(selectedTab: 1));
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (state.dashboardSupervisor.data != null)
                  Column(
                    children: [
                      Container(
                        height: (size.width - 40) / 3 * 2,
                        width: size.width - 40,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: const Color(0XFF1D68F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.chartDataSuperVisor.charts != null
                            ? BarChartB(chart: state.chartDataSuperVisor)
                            : const SizedBox(),
                      ),
                      if (state.dashboardSupervisor.data != null &&
                          state.dashboardSupervisor.data!.onGoing != null)
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            OnGoingVisitCard(
                              goToOngoingScreen:
                                  (String type, VisitData visitData) {
                                    bloc.add(
                                      GoToOnGoingVisitPlanScreen(
                                        visitData: visitData,
                                      ),
                                    );
                                  },
                              onGoingVisit:
                                  state.dashboardSupervisor.data!.onGoing!,
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      if (state.dashboardSupervisor.data!.waitingForApproval !=
                          0)
                        InkWell(
                          onTap: () {
                            bloc.add(
                              const GoToTodaysVisitScreen(
                                planListType: PlanListType.totalVisitPlan,
                                selectedDateDropdown: 3,
                                selectedStatusDropdown: 'Waiting For Approval',
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: DottedBorder(
                            options: RectDottedBorderOptions(
                              color: bGreen,
                              strokeWidth: 1.5,
                              dashPattern: const [4, 3],
                              padding: const EdgeInsets.all(1),
                            ),
                            child: Ink(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0XFFFFF0F1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextB(
                                    text: "Waiting for Approval",
                                    fontColor: bBlack,
                                  ),
                                  TextB(
                                    text: state
                                        .dashboardSupervisor
                                        .data!
                                        .waitingForApproval!
                                        .toString(),
                                    textStyle: bHeadline5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (state.dashboardSupervisor.data!.waitingForApproval !=
                          0)
                        const SizedBox(height: 20),
                      if (state.dashboardSupervisor.data != null &&
                          state.hasAreaPlan)
                        Plan(dashboardResponse: state.dashboardSupervisor),
                      Row(
                        children: [
                          StatusCard(
                            press: () {
                              bloc.add(
                                const GoToTodaysVisitScreen(
                                  selectedDateDropdown: 0,
                                ),
                              );
                            },
                            bgColor: const Color(0XFFEBF8EF),
                            leftIconBgColor: const Color(0XFF39BF5D),
                            leftIcon: todayVisitPlanSvg,
                            title: "Today's Visits",
                            total: state
                                .dashboardSupervisor
                                .data!
                                .todaysVisit!
                                .total!,
                            completed: state
                                .dashboardSupervisor
                                .data!
                                .todaysVisit!
                                .completed!,
                          ),
                          const SizedBox(width: 10),
                          StatusCard(
                            press: () {
                              bloc.add(
                                const GoToTodaysVisitScreen(
                                  planListType: PlanListType.upcomingVisitPlan,
                                  selectedDateDropdown: -1,
                                ),
                              );
                            },
                            bgColor: const Color(0XFFE7F3FF),
                            leftIconBgColor: Colors.cyan,
                            leftIcon: upcomingVisitLogoSvg,
                            title: "Upcoming Visits",
                            total:
                                state.dashboardSupervisor.data!.upcomingVisit!,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          StatusCard(
                            press: () {
                              bloc.add(
                                const GoToTodaysVisitScreen(
                                  planListType: PlanListType.totalVisitPlan,
                                  selectedDateDropdown: 3,
                                ),
                              );
                            },
                            bgColor: const Color(0XFFFFF7E8),
                            leftIconBgColor: const Color(0XFFF9C529),
                            leftIcon: todayVisitPlanSvg,
                            title: "This Month's Visits",
                            total: state
                                .dashboardSupervisor
                                .data!
                                .totalVisitForCurrentMonth!
                                .total!,
                            completed: state
                                .dashboardSupervisor
                                .data!
                                .totalVisitForCurrentMonth!
                                .completed!,
                          ),
                          const SizedBox(width: 10),
                          StatusCard(
                            press: () {
                              bloc.add(GoToEmergencyIssueScreen());
                            },
                            bgColor: const Color(0XFFF2F5FF),
                            leftIconBgColor: const Color(0XFF0D3FE9),
                            leftIcon: emergencyIssueLogoSvg,
                            title: "Emergency Issues",
                            total: state
                                .dashboardSupervisor
                                .data!
                                .emergencyTaskForCurrentMonth!
                                .total!,
                            completed: state
                                .dashboardSupervisor
                                .data!
                                .emergencyTaskForCurrentMonth!
                                .completed!,
                          ),
                        ],
                      ),
                      if (state.dashboardSupervisor.data!.visitorsCount! > 0)
                        const MyTeam(),
                      const SizedBox(height: 40),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
