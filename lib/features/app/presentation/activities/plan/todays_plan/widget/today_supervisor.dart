import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/dropdown_field.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/today_plan_supervisor_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/today_plan_supervisor_state.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/bloc/todays_plan_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/widget/plan_list.dart';
import 'package:work_diary/features/app/presentation/activities/plan/todays_plan/widget/todays_plan_status.dart';

class TodaySupervisor extends StatelessWidget {
  const TodaySupervisor({super.key, required this.loadingStatus});

  final Function loadingStatus;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodaysPlanBlocSupervisor>();
    final size = MediaQuery.of(context).size;
    final scroll = ScrollController();

    return BlocBuilder<TodaysPlanBlocSupervisor, TodaysPlanStateSuperVisor>(
      builder: (context, state) {
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        loadingStatus(state.isLoading);
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(GetTodaysPlan());
            },
            child: ListView(
              padding: EdgeInsets.zero,
              controller: scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0XFFF9F9F9),
                    border: Border.all(color: const Color(0XFFDDDDDD)),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (size.width * 0.5) - 35,
                        child: DropdownFieldB(
                          dropdownHeight: 42,
                          items: state.visitStatusList,
                          selected: (index) {
                            bloc.add(SelectedVisitStatus(selectedIndex: index));
                          },
                          dropDownValue: state.selectedStatus,
                        ),
                      ),
                      Flexible(
                        child: DropdownFieldB(
                          dropdownHeight: 42,
                          items: state.dateList,
                          borderColor: Colors.transparent,
                          bgColor: Colors.transparent,
                          selected: (index) {
                            bloc.add(SelectedVisitDate(selectedIndex: index));
                          },
                          dropDownValue: state.selectedDate,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (state.todayVisits.summery != null)
                  TodaysPlanStatus(summery: state.todayVisits.summery!),
                if (state.todayVisits.summery != null &&
                    state.todayVisits.summery!.ongoingCount != 0)
                  const SizedBox(height: 10),
                if (state.todayVisits.summery != null &&
                    state.todayVisits.summery!.ongoingCount != null &&
                    state.todayVisits.summery!.ongoingCount != 0)
                  DottedBorder(
                    options: RectDottedBorderOptions(
                      color: bGreen,
                      strokeWidth: 1.5,
                      dashPattern: const [4, 3],
                      padding: const EdgeInsets.all(1),
                    ),
                    child: Container(
                      color: Colors.blue.withOpacity(.1),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextB(
                            text: 'Ongoing Visits ',
                            fontWeight: FontWeight.bold,
                            fontColor: bBlack,
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 6,
                              bottom: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.blue.withOpacity(.3),
                            ),
                            child: TextB(
                              text: state.todayVisits.summery!.ongoingCount
                                  .toString(),
                              fontWeight: FontWeight.bold,
                              fontColor: bBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state.todayVisits.data != null)
                  PlanList(
                    isLoading: state.isLoading,
                    isEndList: state.isEndList,
                    planList: state.todayVisits.data!,
                    isSupervisor: state.isSupervisor,
                    goToDetailsScreen: (String visitType, VisitData visitData) {
                      bloc.add(
                        GoToPlanList(planType: visitType, visitData: visitData),
                      );
                    },
                    changeStatus: (int id, String status) {
                      bloc.add(GetComments(id: id, status: status));
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
