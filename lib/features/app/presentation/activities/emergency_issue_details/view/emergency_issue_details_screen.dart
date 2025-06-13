import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/big_camera.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/chips.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/grid_view_file_image.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/emergency_issue_details/bloc/emergency_issue_details_bloc.dart';

class EmergencyIssueDetailsScreen extends StatelessWidget {
  const EmergencyIssueDetailsScreen({Key? key, required this.visitData})
      : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => EmergencyIssueDetailsScreen(
          visitData: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmergencyIssueDetailsBloc(
          getIt<IFlutterNavigator>(),
          getIt<GetLocationRepo>(),
          getIt<ImagePicker>(),
          getIt<ApiRepo>(),
          getIt<LocalStorageRepo>())
        ..add(GetEmergencyIssueId(visitData: visitData)),
      child: const EmergencyIssueDetailsScreenView(),
    );
  }
}

class EmergencyIssueDetailsScreenView extends StatelessWidget {
  const EmergencyIssueDetailsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EmergencyIssueDetailsBloc>();
    final FocusNode commentFocusNode = FocusNode();

    return BlocBuilder<EmergencyIssueDetailsBloc, EmergencyIssueDetailsState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Emergency Issue Details",
        loading: state.loading,
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.allEmergencyIssue.name,
            child: const TextB(text: "All Emergency Issue"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.allEmergencyIssue.name));
            },
          ),
        ],
        bottomSection: Column(
          children: [
            state.emergencyTaskDetails.data != null
                ? Container(
                    child: state.emergencyTaskDetails.data!.canComplete!
                        ? ButtonB(
                            bgColor: bSkyBlue,
                            textColor: bWhite,
                            loading: state.loading,
                            text: "Complete this Emergency Issue",
                            press: () {
                              bloc.add(CompleteEmergencyIssue());
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              bloc.add(GotToIssueList());
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: 15,
                                ),
                                TextB(
                                  text: "Back to emergency issue",
                                  textStyle: bHeadline5,
                                  fontColor: bDark,
                                ),
                              ],
                            ),
                          ),
                  )
                : const SizedBox(),
          ],
        ),
        child: state.emergencyTaskDetails.data != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextB(
                            text:
                                "Task Ref# ${state.emergencyTaskDetails.data!.id} ",
                            textStyle: bBody3,
                            fontColor: bDarkGray,
                          ),
                          const Spacer(),
                          const TextB(
                            text: "Status: ",
                            fontSize: 14,
                            fontColor: bDarkGray,
                          ),
                          ChipsB(
                            text: state.emergencyTaskDetails.data!.status,
                            type: "Ongoing",
                          ),
                        ],
                      ),
                      TextB(
                        text:
                            "Created Date: ${state.emergencyTaskDetails.data!.created!}",
                        textStyle: bBody3,
                        fontColor: bBlack,
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
                      TextB(
                        text:
                            "Committed to complete this issue: ${state.emergencyTaskDetails.data!.dateFor}",
                        fontSize: 14,
                        fontColor: bBlack,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const TextB(
                            text: "Emergency Issue",
                            fontSize: 15,
                            fontColor: bBlue,
                          ),
                          const Spacer(),
                          TextB(
                            text: state.emergencyTaskDetails.data!.forOwn!
                                ? 'Own'
                                : '',
                            textStyle: bBody3,
                            fontColor: bBlue,
                          ),
                          const SizedBox(width: 2),
                        ],
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
                              text: state.emergencyTaskDetails.data!.taskNote ??
                                  '',
                              fontSize: 13,
                              fontColor: bDarkGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BigCamera(
                    press: () {
                      bloc.add(PickImage());
                    },
                    errorText:
                        state.forms == Forms.invalid && state.images.isEmpty
                            ? 'Upload photos'
                            : '',
                  ),
                  GridViewFileImageB(
                    images: state.images,
                  ),
                  const SizedBox(height: 25),
                  TextFieldB(
                      focusNode: commentFocusNode,
                      fieldTitle: "Issue Comments",
                      hintText: "Please write your issue comments",
                      maxLines: 5,
                      maxLength: 200,
                      onChanged: (value) {
                        bloc.add(GetComments(comments: value));
                      }),
                ],
              )
            : Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 20),
                child: const CircularProgressIndicator(),
              ),
      );
    });
  }
}
