import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/entities/dashboard_response.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/plan_item.dart';

class Plan extends StatelessWidget {
  const Plan({super.key, required this.dashboardResponse});

  final DashboardResponse dashboardResponse;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = context.read<DashboardBloc>();

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              PlanItem(
                image: planIconSvg,
                name: "Today's plan",
                number: dashboardResponse.data!.todaysPlan!.toString(),
                press: () {
                  bloc.add(const GoToTodayPlanScreen(selectedDateDropdown: 0));
                },
              ),
              const SizedBox(width: 10),
              PlanItem(
                image: upcomingPlanSvg,
                name: "Upcoming plan",
                number: dashboardResponse.data!.upcomingPlan.toString(),
                press: () {
                  bloc.add(const GoToTodayPlanScreen(
                      planListType: PlanListType.upcomingVisitPlan,
                      selectedDateDropdown: -1));
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              PlanItem(
                image: waitingApprovalPlanSvg,
                name: "Waiting for approval plan",
                number:
                    dashboardResponse.data!.waitingForPlanApproval.toString(),
                width: size.width / 4 * 3 - 50,
                press: () {
                  bloc.add(const GoToTodayPlanScreen(
                      planListType: PlanListType.upcomingVisitPlan,
                      selectedDateDropdown: 3,
                      selectedStatusDropdown: "Waiting For Approval"));
                },
              ),
              const SizedBox(width: 10),
              PlanItemAdd(
                press: () {
                  bloc.add(GoToAddNewPlanScreen());
                },
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
