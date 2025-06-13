import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import '../bloc/complete_emergency_issue_details_bloc.dart';

class CompleteEmergencyIssueScreen extends StatelessWidget {
  const CompleteEmergencyIssueScreen({Key? key, required this.visitData})
    : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => CompleteEmergencyIssueScreen(visitData: visitData),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteEmergencyIssueDetailsBloc(
        getIt<IFlutterNavigator>(),
        getIt<ApiRepo>(),
        getIt<LocalStorageRepo>(),
      )..add(GetIssueId(visitData: visitData)),
      child: const CompleteEmergencyIssueView(),
    );
  }
}

class CompleteEmergencyIssueView extends StatelessWidget {
  const CompleteEmergencyIssueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CompleteEmergencyIssueDetailsBloc>();

    return BlocBuilder<
      CompleteEmergencyIssueDetailsBloc,
      CompleteEmergencyIssueDetailsState
    >(
      builder: (context, state) {
        return CommonBodyB(
          appBarTitle: "Completed Emergency Issue",
          loading: state.loading,
          menuList: [
            PopupMenuItem(
              value: PopUpMenu.allEmergencyIssue.name,
              child: const TextB(text: "All Emergency Issue"),
            ),
          ],
          bottomSection: ButtonB(
            bgColor: bSkyBlue,
            textColor: bWhite,
            text: "Back to Emergency Issue",
            press: () {
              bloc.add(GoToEmergencyIssueScreen());
            },
          ),
          child: state.emergencyTaskDetails.data != null
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 20),
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
                          text: state.emergencyTaskDetails.data!.status!,
                          type: "Complete",
                        ),
                      ],
                    ),
                    TextB(
                      text:
                          "Committed to complete this issue: ${state.emergencyTaskDetails.data!.created!}",
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
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextB(
                      text: state.emergencyTaskDetails.data!.name!,
                      fontSize: 26,
                      fontHeight: 1.1,
                      fontColor: bBlack,
                    ),
                    const SizedBox(height: 5),
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
                                state.emergencyTaskDetails.data!.taskNote ?? '',
                            fontSize: 13,
                            fontColor: bDarkGray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridViewNetworkImage(
                      images:
                          state.emergencyTaskDetails.data!.visitImages ?? [],
                    ),
                    const SizedBox(height: 50),
                    DottedBorder(
                      options: RectDottedBorderOptions(
                        color: bGreen,
                        strokeWidth: 1.5,
                        dashPattern: const [4, 3],
                        padding: const EdgeInsets.all(1),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0XFFFFFBED),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextB(
                              text:
                                  "Issue Note: ${state.emergencyTaskDetails.data!.comments ?? ''}",
                              fontColor: bDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20),
                  child: const CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
