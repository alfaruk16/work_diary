import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/features/app/presentation/activities/incomplete_visit/bloc/incomplete_visit_bloc.dart';

class IncompleteVisitScreen extends StatelessWidget {
  const IncompleteVisitScreen({Key? key, required this.visitData})
      : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => IncompleteVisitScreen(
          visitData: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IncompleteVisitBloc(getIt<ApiRepo>())
        ..add(GetVisitDetails(visitData: visitData)),
      child: const IncompleteVisitView(),
    );
  }
}

class IncompleteVisitView extends StatelessWidget {
  const IncompleteVisitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<CompletedVisitPlanBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<IncompleteVisitBloc, IncompleteVisitState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Incomplete Visit Plan",
        child: state.visit.visitData != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0XFFFB8C00),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const TextB(
                      text: "This visit Plan is Incomplete",
                      textStyle: bHeadline6,
                      fontColor: bWhite,
                      alignMent: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextB(
                    text: "You don't able to edit this visit plan",
                    fontSize: 16,
                    fontColor: bBlack,
                  ),
                  const SizedBox(height: 30),
                  VisitInfo(
                    title: "Visit Ref#",
                    info: '${state.visit.visitData!.id!}',
                    infoColor: bBlack,
                    infoFontSize: 20,
                    infoFontWeight: FontWeight.w500,
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
                    info: state.visit.visitData!.status!,
                    infoColor: const Color(0XFFFB8C00),
                    infoFontSize: 12,
                  ),
                  const SizedBox(height: 20),
                  VisitInfo(
                    iconName: visitBuildingSvg,
                    title: "Shop Name & id",
                    info:
                        '${state.visit.visitData!.unitName!}  (Shop id: ${state.visit.visitData!.unitCode ?? ''})',
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
                          info: state.visit.visitData!.createdBy!,
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
                          title: "Visit Note",
                          info: state.visit.visitData!.visitNote!,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  const SizedBox(height: 15),
                  const TextB(
                    text: "Visit Photos",
                    fontSize: 16,
                    fontColor: bBlack,
                  ),
                  GridViewNetworkImage(
                    images: state.visit.visitData!.visitImages!,
                  ),
                  const SizedBox(height: 20),
                  if (state.visit.formList != null)
                    AddFormItem(
                      editable: false,
                      formList: state.visit.formList!,
                    ),
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
