import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/chips.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue_cancelled/bloc/emergency_issue_cancelled_bloc.dart';

class EmergencyIssueCancelledScreen extends StatelessWidget {
  const EmergencyIssueCancelledScreen({Key? key, required this.visitData})
    : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => EmergencyIssueCancelledScreen(visitData: visitData),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmergencyIssueCancelledBloc(
        getIt<IFlutterNavigator>(),
        getIt<ApiRepo>(),
      )..add(GetEmergencyIssueId(visitData: visitData)),
      child: const EmergencyIssueCancelledScreenView(),
    );
  }
}

class EmergencyIssueCancelledScreenView extends StatelessWidget {
  const EmergencyIssueCancelledScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EmergencyIssueCancelledBloc>();

    return BlocBuilder<
      EmergencyIssueCancelledBloc,
      EmergencyIssueCancelledState
    >(
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        return CommonBodyB(
          appBarTitle: "Cancelled Emergency Issue",
          loading: state.loading,
          menuList: [
            PopupMenuItem(
              value: PopUpMenu.allEmergencyIssue.name,
              child: const TextB(text: "All Emergency Issue"),
              onTap: () {
                bloc.add(
                  MenuItemScreens(name: PopUpMenu.allEmergencyIssue.name),
                );
              },
            ),
          ],
          bottomSection: state.emergencyTaskDetails.data != null
              ? GestureDetector(
                  onTap: () {
                    bloc.add(GotToIssueList());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios, size: 15),
                      TextB(
                        text: "Back to emergency issue",
                        textStyle: bHeadline5,
                        fontColor: bDark,
                      ),
                    ],
                  ),
                )
              : null,
          child: state.emergencyTaskDetails.data != null
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextB(
                          text:
                              "Task Ref# ${state.emergencyTaskDetails.data!.id} ",
                          textStyle: bBody3,
                          fontColor: bDarkGray,
                        ),
                        Row(
                          children: [
                            const TextB(
                              text: "Created Date: ",
                              textStyle: bBody3,
                              fontColor: bBlack,
                            ),
                            TextB(
                              text: state.emergencyTaskDetails.data!.created!,
                              textStyle: bBody3,
                              fontColor: bBlack,
                            ),
                            const Spacer(),
                            const TextB(
                              text: "Status: ",
                              fontSize: 12,
                              fontColor: bDarkGray,
                            ),
                            ChipsB(
                              text: state.emergencyTaskDetails.data!.status,
                              type: "Cancelled",
                            ),
                          ],
                        ),
                        TextB(
                          text:
                              "Committed to complete this issue: ${state.emergencyTaskDetails.data!.dateFor}",
                          fontSize: 12,
                          fontColor: bBlack,
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            TextB(
                              text: "Emergency Issue",
                              fontSize: 12,
                              fontColor: bBlue,
                            ),
                            Spacer(),
                            TextB(
                              text: "Priority: ",
                              fontSize: 12,
                              fontColor: bBlack,
                            ),
                            TextB(
                              text: "Medium",
                              fontSize: 12,
                              fontColor: bSkyBlue,
                            ),
                          ],
                        ),
                        TextB(
                          text:
                              "Created By: ${state.emergencyTaskDetails.data!.createdBy}",
                          fontSize: 14,
                          fontColor: bBlack,
                        ),
                        TextB(
                          text:
                              "Supervisor: ${state.emergencyTaskDetails.data!.supervisor}",
                          fontSize: 14,
                          fontColor: bBlack,
                        ),
                        TextB(
                          text:
                              "Assaign to: ${state.emergencyTaskDetails.data!.assaignTo}",
                          fontSize: 14,
                          fontColor: bBlack,
                        ),
                        const SizedBox(height: 10),
                        TextB(
                          text: state.emergencyTaskDetails.data!.name!,
                          fontSize: 22,
                          fontHeight: 1.5,
                          fontColor: bBlack,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextB(
                              text: "Note: ",
                              fontSize: 13,
                              fontColor: bBlack,
                            ),
                            Flexible(
                              child: TextB(
                                text:
                                    state.emergencyTaskDetails.data!.taskNote ??
                                    '',
                                fontSize: 13,
                                fontColor: bDarkGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (state.emergencyTaskDetails.data!.comments != null)
                          DottedBorder(
                            options: RectDottedBorderOptions(
                              color: bGreen,
                              strokeWidth: 1.5,
                              dashPattern: const [4, 3],
                              padding: const EdgeInsets.all(1),
                            ),
                            child: Container(
                              width: size.width * 1 - 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: bLightRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextB(
                                    text: "Comments:",
                                    fontColor: bDark,
                                    textStyle: bHeadline5,
                                  ),
                                  TextB(
                                    text:
                                        state
                                            .emergencyTaskDetails
                                            .data!
                                            .comments!
                                            .isEmpty
                                        ? 'No Comments'
                                        : state
                                              .emergencyTaskDetails
                                              .data!
                                              .comments!,
                                    fontColor: bDark,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                )
              : Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: const CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
