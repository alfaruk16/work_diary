import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/widgets/dropdown_field.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/visit_status.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_bloc_supervisor.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/bloc/emergency_issue_state_supervisor.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/widgets/emergency_task_status.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue/widgets/issue_list.dart';

class SupervisorEmergency extends StatelessWidget {
  const SupervisorEmergency({super.key, required this.loaderStatus});

  final Function loaderStatus;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EmergencyIssueBlocSupervisor>();
    final size = MediaQuery.of(context).size;
    final scroll = ScrollController();

    return BlocBuilder<EmergencyIssueBlocSupervisor,
        EmergencyIssueStateSupervisor>(builder: (context, state) {
      scroll.addListener(() {
        if (scroll.position.pixels == scroll.position.maxScrollExtent) {
          bloc.add(PageIncrement());
        }
      });
      loaderStatus(state.isLoading);
      return Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          color: Colors.white,
          child: RefreshIndicator(
              onRefresh: () async {
                bloc.add(Reload());
              },
              child: ListView(
                padding: EdgeInsets.zero,
                controller: scroll,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 20),
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
                          width: (size.width * 0.5) - 30,
                          child: DropdownFieldB(
                            items: state.visitStatusList,
                            selected: (index) {
                              bloc.add(
                                  SelectedVisitStatus(selectedIndex: index));
                            },
                            dropDownValue: getStatusDropdownIndex(
                                state.selectedVisitStatus,
                                state.visitStatus.data),
                          ),
                        ),
                        SizedBox(
                          width: (size.width * 0.5) - 30,
                          child: DropdownFieldB(
                            items: state.dateList,
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
                  if (state.emergencyIssue.summery != null)
                    EmergencyTaskStatus(
                      summery: state.emergencyIssue.summery!,
                    ),
                  const SizedBox(height: 10),
                  if (state.emergencyIssue.data != null)
                    IssueList(
                        isLoading: state.incrementLoader,
                        isEndList: state.isEndList,
                        listTitle: state.listForDates,
                        planList: state.emergencyIssue.data!,
                        goToDetailsScreen: (String type, VisitData visitData) {
                          bloc.add(GoToPlanList(
                              planType: type, visitData: visitData));
                        },
                        changeStatus: (int id, String status) {
                          bloc.add(GetComments(id: id, status: status));
                        })
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
