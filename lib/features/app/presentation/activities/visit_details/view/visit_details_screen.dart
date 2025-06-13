import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/form/widgets/slot.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/features/app/presentation/activities/visit_details/bloc/visit_details_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/visit_details/widget/emergency_visit_cart.dart';

class VisitDetailsScreen extends StatelessWidget {
  const VisitDetailsScreen({Key? key, required this.visitData})
      : super(key: key);

  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => VisitDetailsScreen(
          visitData: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisitDetailsBloc(
        getIt<IFlutterNavigator>(),
        getIt<ApiRepo>(),
      )..add(GetVisitId(visitData: visitData)),
      child: const VisitDetailsView(),
    );
  }
}

class VisitDetailsView extends StatelessWidget {
  const VisitDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VisitDetailsBloc>();
    final size = MediaQuery.of(context).size;
    return BlocBuilder<VisitDetailsBloc, VisitDetailsState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Visit Details",
        loading: state.loading,
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.createNewVisitPlan.name,
            child: const TextB(text: "New Visit"),
            onTap: () {
              bloc.add(GoToCreateNewVisitPlan());
            },
          ),
          PopupMenuItem(
            value: PopUpMenu.allVisitPlan.name,
            child: const TextB(text: "All Visit"),
            onTap: () {
              bloc.add(GoToTodayVisitPlan());
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
        bottomSection: state.visitDetails.visitData != null &&
                state.visitDetails.visitData!.btns!.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    state.visitDetails.visitData!.btns!.length,
                    (index) => SizedBox(
                      width: state.visitDetails.visitData!.btns != null &&
                              state.visitDetails.visitData!.btns!.length == 1 &&
                              state.visitDetails.visitData!.canStart != null &&
                              !state.visitDetails.visitData!.canStart!
                          ? size.width * 1 - 40
                          : size.width * 0.5 - 30,
                      child: ButtonB(
                        press: () {
                          bloc.add(GetComments(
                              id: state.visitDetails.visitData!.id!,
                              status: state.visitDetails.visitData!
                                  .btns![index]!.value!));
                        },
                        text: state.visitDetails.visitData!.btns![index]!.name,
                        textColor:
                            state.visitDetails.visitData!.btns![index]!.value !=
                                    'approved'
                                ? bDarkRed
                                : bWhite,
                        borderColor:
                            state.visitDetails.visitData!.btns![index]!.value !=
                                    'approved'
                                ? const Color(0XFFFFCBCB)
                                : Colors.transparent,
                        bgColor:
                            state.visitDetails.visitData!.btns![index]!.value !=
                                    'approved'
                                ? const Color(0XFFFBEBEB)
                                : bBlue,
                        shadow: false,
                        loading: state.cancelLoading,
                      ),
                    ),
                  ),
                  if (state.visitDetails.visitData!.canStart != null &&
                      state.visitDetails.visitData!.canStart!)
                    SizedBox(
                      width: state.visitDetails.visitData!.btns!.length == 1
                          ? size.width * 0.5 - 30
                          : size.width * 1 - 40,
                      child: ButtonB(
                        text: "Start Visit",
                        press: () {
                          bloc.add(StartCheckIn(
                              unitCode: state.visitDetails.visitData!.unitCode!,
                              unitName:
                                  state.visitDetails.visitData!.unitName!));
                        },
                        bgColor: bBlue,
                        textColor: bWhite,
                        loading: state.startLoading,
                      ),
                    ),
                ],
              )
            : state.visitDetails.visitData != null &&
                    state.visitDetails.visitData!.canStart != null &&
                    state.visitDetails.visitData!.canStart!
                ? SizedBox(
                    width: size.width - 40,
                    child: ButtonB(
                      text: "Start Visit",
                      press: () {
                        bloc.add(StartCheckIn(
                            unitCode: state.visitDetails.visitData!.unitCode!,
                            unitName: state.visitDetails.visitData!.unitName!));
                      },
                      bgColor: bBlue,
                      textColor: bWhite,
                      loading: state.loading,
                    ),
                  )
                : null,
        child: state.visitDetails.visitData != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 112,
                    child: Stack(
                      children: [
                        Container(
                            height: 112,
                            decoration: const BoxDecoration(
                                color: bDarkBlue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child:
                                SvgPicture.asset(clockBgSvg, fit: BoxFit.fill)),
                        SizedBox(
                          height: 112,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextB(
                                text: state.visitDetails.visitData!.isUpcoming!
                                    ? "Upcoming"
                                    : state.time,
                                textStyle: bHeadline1,
                                fontColor: bWhite,
                              ),
                              const SizedBox(height: 5),
                              TextB(
                                text:
                                    'Visit Date: ${state.visitDetails.visitData!.dateFor!}',
                                textStyle: bHeadline4,
                                fontColor: bWhite,
                                fontHeight: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.visitDetails.visitData!.status! == "Approved" &&
                      state.visitDetails.visitData!.isSlotEnabled != null &&
                      state.visitDetails.visitData!.isSlotEnabled! &&
                      state.visitDetails.visitData!.slot != null)
                    SlotView(
                      slot: state.visitDetails.visitData!.slot!,
                      edit: () {
                        bloc.add(EditSlot());
                      },
                      complete: () {
                        bloc.add(CompleteSlot());
                      },
                    ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    title: "Visit Ref#",
                    info: '${state.visitDetails.visitData!.id!}',
                    infoColor: bBlack,
                    infoFontSize: 20,
                    infoFontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    title: "Visit Name",
                    info: state.visitDetails.visitData!.name!,
                    infoColor: bBlack,
                    infoFontSize: 20,
                    infoFontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitStatusSvg,
                    title: "Visit Status",
                    info: state.visitDetails.visitData!.status == "Approved"
                        ? "Not started yet${state.visitDetails.visitData!.isExtended! ? " (Continued visit)" : ''}"
                        : state.visitDetails.visitData!.status!,
                    infoColor: bDarkBlue,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitBuildingSvg,
                    title: "Shop Name & id",
                    info:
                        '${state.visitDetails.visitData!.unitName ?? ''}  (Shop id: ${state.visitDetails.visitData!.unitCode ?? ''})',
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitMapSvg,
                    title: "Shop Route (Location)",
                    info: state.visitDetails.visitData!.unitAddress != null
                        ? state.visitDetails.visitData!.unitAddress!
                        : 'Location',
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitCreateSvg,
                    title: "Created Date",
                    info: state.visitDetails.visitData!.created!,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitCreateSvg,
                    title: "Date For",
                    info: state.visitDetails.visitData!.dateFor!,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: VisitInfo(
                          iconName: visitCreateSvg,
                          title: "Created by",
                          info: state.visitDetails.visitData!.createdBy!,
                        ),
                      ),
                      state.visitDetails.visitData!.supervisor != null
                          ? Flexible(
                              child: VisitInfo(
                                iconName: visitApprovedSvg,
                                infoColor: bGreen,
                                title: "Approved by",
                                info: state.visitDetails.visitData!.supervisor!,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitApprovedSvg,
                    title: "Assigned",
                    info: state.visitDetails.visitData!.assaignTo!,
                  ),
                  const SizedBox(height: 20),
                  if (state.visitDetails.visitData!.visitNote != null)
                    Column(
                      children: [
                        VisitInfo(
                          iconName: visitNoteSvg,
                          title: "Visit Note",
                          info: state.visitDetails.visitData!.visitNote!,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  GridViewNetworkImage(
                    images: state.visitDetails.visitData!.visitImages!,
                  ),
                  const SizedBox(height: 30),
                  if (state.emergencyIssue.data != null)
                    ...List.generate(
                      state.emergencyIssue.data!.length,
                      (index) => EmergencyVisitCart(
                        press: () {
                          bloc.add(EmergencyIssueDetails(
                              visitData: state.emergencyIssue.data![index]));
                        },
                        icon: emergencySvg,
                        subTitle: "Emergency Issue",
                        title: state.emergencyIssue.data![index].name,
                        name: state.emergencyIssue.data![index].unitName,
                      ),
                    ),
                ],
              )
            : Container(
                padding: const EdgeInsets.only(top: 20),
                child: const CircularProgressIndicator(),
              ),
      );
    });
  }
}
