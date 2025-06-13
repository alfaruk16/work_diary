import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/widgets/dropdown_field.dart';
import 'package:work_diary/core/widgets/on_going_card.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/today_visit_own_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/today_visit_own_state.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/bloc/todays_visit_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/widget/plan_list.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/widget/todays_plan_status.dart';

class TodayOwn extends StatelessWidget {
  const TodayOwn({super.key, required this.loadingStatus});

  final Function loadingStatus;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodaysVisitBlocOwn>();
    final size = MediaQuery.of(context).size;
    final scroll = ScrollController();

    return BlocBuilder<TodaysVisitBlocOwn, TodaysVisitStateOwn>(
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
                bloc.add(GetTodaysVisitPlan());
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
                        border: Border.all(
                          color: const Color(0XFFDDDDDD),
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (size.width * 0.5) - 35,
                          child: DropdownFieldB(
                              dropdownHeight: 42,
                              items: state.visitStatusList,
                              selected: (index) {
                                bloc.add(
                                    SelectedVisitStatus(selectedIndex: index));
                              },
                              dropDownValue: state.selectedStatus),
                        ),
                        Flexible(
                          child: DropdownFieldB(
                              dropdownHeight: 42,
                              items: state.dateList,
                              borderColor: Colors.transparent,
                              bgColor: Colors.transparent,
                              selected: (index) {
                                bloc.add(
                                    SelectedVisitDate(selectedIndex: index));
                              },
                              dropDownValue: state.selectedDate),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (state.todayVisits.summery != null)
                    TodaysPlanStatus(summery: state.todayVisits.summery!),
                  const SizedBox(height: 10),
                  if (state.todayVisits.ongoing != null)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        OnGoingVisitCard(
                          onGoingVisit: state.todayVisits.ongoing!,
                          goToOngoingScreen:
                              (String type, VisitData visitData) {
                            bloc.add(GoToPlanList(
                                planType: type, visitData: visitData));
                          },
                        ),
                        const SizedBox(height: 5)
                      ],
                    ),
                  if (state.todayVisits.data != null)
                    PlanList(
                      isLoading: state.incrementLoader,
                      isEndList: state.isEndList,
                      planList: state.todayVisits.data!,
                      isSupervisor: state.isSupervisor,
                      goToDetailsScreen:
                          (String visitType, VisitData visitData) {
                        bloc.add(GoToPlanList(
                            planType: visitType, visitData: visitData));
                      },
                      changeStatus: (int id, String status) {
                        bloc.add(GetComments(id: id, status: status));
                      },
                    )
                ],
              )));
    });
  }

  int getStatusDropdownIndex(String selectedVisitStatus, List<Status>? data) {
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].value == selectedVisitStatus) {
          return i;
        }
      }
    }
    return -1;
  }
}
