import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/features/app/presentation/activities/plan/plan_cancelled/bloc/plan_cancelled_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/visit_cancelled/widget/reason.dart';

class PlanCancelledScreen extends StatelessWidget {
  const PlanCancelledScreen({Key? key, required this.visitData})
      : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => PlanCancelledScreen(
          visitData: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PlanCancelledBloc(getIt<IFlutterNavigator>(), getIt<ApiRepo>())
            ..add(VisiDetailsById(visitData: visitData)),
      child: const PlanCancelledView(),
    );
  }
}

class PlanCancelledView extends StatelessWidget {
  const PlanCancelledView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlanCancelledBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<PlanCancelledBloc, PlanCancelledState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Cancelled Visit",
        loading: state.loading,
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.createNewPlan.name,
            child: const TextB(text: "New Plan"),
            onTap: () {
              bloc.add(GoToCreateNewPlan());
            },
          ),
          PopupMenuItem(
            value: PopUpMenu.allPlan.name,
            child: const TextB(text: "All Plan"),
            onTap: () {
              bloc.add(GoToTodayPlan());
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
        bottomSection: state.visit.visitData != null
            ? Column(
                children: [
                  ButtonB(
                      text: "Back To All Plan",
                      press: () {
                        bloc.add(GotoPlanList());
                      },
                      textColor: bDarkRed,
                      borderColor: const Color(0XFFFFCBCB),
                      bgColor: const Color(0XFFFBEBEB)),
                ],
              )
            : null,
        child: state.visit.visitData != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                            height: size.width / 3,
                            child: Image.asset(postponePng)),
                        const SizedBox(height: 15),
                        const TextB(
                          text: "This Plan is Cancelled",
                          textStyle: bHeadline4,
                          fontColor: Color(0XFFF34C75),
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          width: 100,
                          child: Divider(
                            height: 0,
                            thickness: 3,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  //nothing
                  VisitInfo(
                    title: "Plan Ref#",
                    info: '${state.visit.visitData!.id!}',
                    infoColor: bBlack,
                    infoFontSize: 20,
                    infoFontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    title: "Plan Name",
                    info: state.visit.visitData!.name!,
                    infoColor: bBlack,
                    infoFontSize: 20,
                    infoFontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitStatusSvg,
                    title: "Plan Status",
                    info: state.visit.visitData!.status!,
                    infoColor: const Color(0XFFF34C75),
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
                            title: "Supervisor",
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
                          title: "Plan Note",
                          info: state.visit.visitData!.visitNote!,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  const SizedBox(height: 15),
                  Reason(
                    title: "Cancel Reason",
                    text: state.visit.visitData!.comments ?? '',
                  ),
                  const SizedBox(height: 15),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
