import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/form/widgets/slot.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/bloc/bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';

class OngoingVisitPlanScreen extends StatelessWidget {
  const OngoingVisitPlanScreen({Key? key, required this.visitData})
      : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => OngoingVisitPlanScreen(
          visitData: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OngoingVisitPlanBloc(getIt<IFlutterNavigator>(),
          getIt<ApiRepo>(), getIt<GetLocationRepo>(), getIt<LocalStorageRepo>())
        ..add(AddData(visitData: visitData))
        ..add(OnGoingVisitById(visitData: visitData)),
      child: const OngoingVisitPlanView(),
    );
  }
}

class OngoingVisitPlanView extends StatelessWidget {
  const OngoingVisitPlanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OngoingVisitPlanBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<OngoingVisitPlanBloc, OngoingVisitPlanState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Ongoing Visit plan",
        onBack: () {
          bloc.add(GoToTodaysVisit());
        },
        loading: state.loading,
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.createNewVisitPlan.name,
            child: const TextB(text: "Create New Visit Plan"),
            onTap: () {
              bloc.add(GoToCreateNewVisitPlan());
            },
          ),
          PopupMenuItem(
            value: PopUpMenu.allVisitPlan.name,
            child: const TextB(text: "All Visit Plan"),
            onTap: () {
              bloc.add(GoToTodaysVisit());
            },
          ),
          PopupMenuItem(
            value: PopUpMenu.dashboard.name,
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(GoToDashboard());
            },
          )
        ],
        bottomSection: state.visit.visitData != null &&
                state.visit.visitData!.canComplete != null &&
                state.visit.visitData!.canComplete!
            ? Column(
                children: [
                  if (state.visit.visitData != null)
                    TextB(
                      text:
                          'Started Time: ${state.visit.visitData!.startedTime}',
                      textStyle: bHeadline6,
                    ),
                  const SizedBox(height: 5),
                  ButtonB(
                    press: () {
                      bloc.add(
                          CheckVisitForms(visitId: state.visit.visitData!.id!));
                    },
                    text: "Complete this visit plan",
                    textColor: bWhite,
                    bgColor: bBlue,
                    shadow: true,
                    loading: state.loading,
                  ),
                ],
              )
            : null,
        child: state.visit.visitData != null
            ?  ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 25),
                  Container(
                    height: 48,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: const Color(0XFFE9F0FF),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(topMassageBgPng),
                        const TextB(
                          text: "Right now this visit is running",
                          textStyle: bHeadline6,
                          fontColor: bWhite,
                          alignMent: TextAlign.center,
                          fontSize: 16,
                        )
                      ],
                    ),
                  ),
                  if (state.visit.visitData!.isSlotEnabled != null &&
                      state.visit.visitData!.isSlotEnabled! &&
                      state.visit.visitData!.slot != null)
                    SlotView(
                      slot: state.visit.visitData!.slot!,
                      edit: () {
                        bloc.add(EditSlot());
                      },
                      complete: () {
                        bloc.add(CompleteSlot());
                      },
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                          child: VisitInfo(
                        title: "Visit Ref#",
                        info: state.visit.visitData!.id.toString(),
                        infoColor: bBlack,
                        infoFontSize: 20,
                        infoFontWeight: FontWeight.w500,
                      )),
                      if (state.visit.visitData!.forOwn!)
                        const TextB(
                          text: 'Own',
                          fontColor: bBlue,
                        ),
                      const SizedBox(width: 5)
                    ],
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    title: "Visit Name",
                    info: state.visit.visitData!.name!,
                    infoColor: bBlack,
                    infoFontSize: 20,
                    infoFontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitStatusSvg,
                    title: "Visit Status",
                    info: state.visit.visitData!.status == "Approved"
                        ? "Not yet checking"
                        : state.visit.visitData!.status!,
                    infoColor: bDarkBlue,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitBuildingSvg,
                    title: "Shop Name & id",
                    info:
                        '${state.visit.visitData!.unitName ?? ''}  (Shop id: ${state.visit.visitData!.unitCode ?? ''})',
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitMapSvg,
                    title: "Shop Route (Location)",
                    info: state.visit.visitData!.unitAddress != null
                        ? state.visit.visitData!.unitAddress!
                        : 'Location',
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitCreateSvg,
                    title: "Created Date",
                    info: state.visit.visitData!.created!,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: VisitInfo(
                          iconName: visitCreateSvg,
                          title: "Created by",
                          info: state.visit.visitData!.createdBy ?? '',
                        ),
                      ),
                      if (state.visit.visitData!.supervisor != null)
                        Flexible(
                          child: VisitInfo(
                            iconName: visitApprovedSvg,
                            infoColor: bGreen,
                            title: "Approved by",
                            info: state.visit.visitData!.supervisor!,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (state.visit.visitData!.visitNote != null)
                    Column(
                      children: [
                        VisitInfo(
                          iconName: visitNoteSvg,
                          title: "Visit Note",
                          info: state.visit.visitData!.visitNote!,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  GridViewNetworkImage(
                    images: state.visit.visitData!.visitImages!,
                  ),
                  const SizedBox(height: 30),
                  if (state.visit.formList != null)
                    AddFormItem(
                      press: (int index) {
                        bloc.add(GoToForm(
                            formItem: state.visit.formList![index]!,
                            visitData: state.visit.visitData!));
                      },
                      deleteForm: ({required int id, required int formId}) {
                        bloc.add(VisitFormDeleteEvent(
                          id: id,
                          formId: formId,
                          visitId: state.visitId,
                        ));
                      },
                      editForm: (FormList item, int? visitFormId) {
                        bloc.add(EditForm(
                            formItem: item,
                            visitData: state.visit.visitData!,
                            visitFormId: visitFormId!));
                      },
                      formList: state.visit.formList!,
                      canComplete: state.visit.visitData!.canComplete!,
                    ),
                  const SizedBox(height: 20)
                ],
              )
            : Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
      );
    });
  }
}
