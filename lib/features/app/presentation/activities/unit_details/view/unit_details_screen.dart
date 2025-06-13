import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/unit_details/bloc/unit_details_bloc.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({Key? key, required this.unit}) : super(key: key);
  final UnitData unit;

  static Route<dynamic> route({required UnitData unit}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => UnitDetailsScreen(unit: unit),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UnitDetailsBloc(getIt<ApiRepo>(), getIt<IFlutterNavigator>())
            ..add(GetCompanyUnitDetails(unitData: unit)),
      child: const UnitDetailsView(),
    );
  }
}

class UnitDetailsView extends StatelessWidget {
  const UnitDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UnitDetailsBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Unit Details",
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(GoToDashboard());
            },
          )
        ],
        bottomSection: ButtonB(
          shadow: true,
          text: 'Back to Unit List',
          press: () {
            bloc.add(GoToAddNewUnit());
          },
        ),
        child: state.unitDetail.data != null
            ? Material(
                color: bWhite,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: const Color(0XFFFFD249),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(topMassageBg2Png),
                          const TextB(
                            text: "Unit Details",
                            textStyle: bHeadline6,
                            fontColor: bWhite,
                            alignMent: TextAlign.center,
                            fontSize: 16,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      title: "Ref#",
                      info: '${state.unitDetail.data!.companyUnitId}',
                      infoColor: bBlack,
                      infoFontSize: 20,
                      infoFontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: visitStatusSvg,
                      title: "Unit Status",
                      info: state.unitDetail.data!.status ?? '',
                      infoColor: bGreen,
                      infoFontSize: 12,
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: visitNoteSvg,
                      title: "Unit Name",
                      info: state.unitDetail.data!.name!,
                      infoColor: bBlack,
                      infoFontSize: 20,
                      infoFontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: visitBuildingSvg,
                      title: "Unit Owner Name",
                      info: state.unitDetail.data!.owner!,
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: mobileSvg,
                      title: "Unit Owner Mobile",
                      info: state.unitDetail.data!.mobile!,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: VisitInfo(
                            iconName: visitBuildingSvg,
                            title: "Unit Id",
                            info: state.unitDetail.data!.code!,
                          ),
                        ),
                        Flexible(
                          child: VisitInfo(
                            iconName: visitBuildingSvg,
                            title: "Unit Type",
                            info: state.unitDetail.data!.unitType!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: VisitInfo(
                            iconName: visitBuildingSvg,
                            title: "Dealer Unit?",
                            info:
                                state.unitDetail.data!.asDealer! ? 'Yes' : 'No',
                          ),
                        ),
                        Flexible(
                          child: VisitInfo(
                            iconName: visitBuildingSvg,
                            title: "Sub Dealer Unit?",
                            info: state.unitDetail.data!.asSubDealer!
                                ? 'Yes'
                                : 'No',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: visitMapSvg,
                      title: "Location",
                      info: state.unitDetail.data!.location!,
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: visitMapSvg,
                      title: "Unit Address",
                      info: state.unitDetail.data!.address!,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: VisitInfo(
                            iconName: visitBuildingSvg,
                            title: "Created Date",
                            info: state.unitDetail.data!.created ?? '',
                          ),
                        ),
                        Flexible(
                          child: VisitInfo(
                            iconName: visitCreateSvg,
                            title: "Created By",
                            info: state.unitDetail.data!.createdBy ?? '',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    VisitInfo(
                      iconName: visitNoteSvg,
                      title: "Total Visits Count",
                      info: state.unitDetail.data!.visitCount != null
                          ? state.unitDetail.data!.visitCount.toString()
                          : '',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
