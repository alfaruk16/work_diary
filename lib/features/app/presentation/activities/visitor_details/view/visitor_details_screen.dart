import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/bar_chart.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/profile_header.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/widgets/information_item.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/widgets/title.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_details/bloc/visitor_details_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_details/widgets/assaign_visit_card.dart';

class VisitorDetailsScreen extends StatelessWidget {
  const VisitorDetailsScreen({Key? key, required this.visitorDetails})
      : super(key: key);
  final Visitor visitorDetails;

  static Route<dynamic> route({required Visitor visitor}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => VisitorDetailsScreen(visitorDetails: visitor),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisitorDetailsBloc(getIt<ApiRepo>(),
          getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
        ..add(GetDetailsById(visitorInfo: visitorDetails)),
      child: const VisitorDetailsView(),
    );
  }
}

class VisitorDetailsView extends StatelessWidget {
  const VisitorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VisitorDetailsBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<VisitorDetailsBloc, VisitorDetailsState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Team Member Details",
        loading: state.pageLoader,
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.dashboard.name,
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(GoToDashboard());
            },
          )
        ],
        child: state.visitorDetails.data != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  ProfileHeader(
                    size: 110,
                    image: state.visitorDetails.data!.avatar ?? photoPng,
                    isRowHeader: false,
                    userName: state.visitorDetails.data!.name,
                    title: state.visitorDetails.data!.designation,
                  ),
                  const SizedBox(height: 20),

                  AssignVisitCard(
                    press: () {
                      bloc.add(AssignVisit(
                          visitorId: state.visitorDetails.data!.id!));
                    },
                  ),
                  const SizedBox(height: 20),
                  // const DropDownCont(),
                  Ttile(
                    press: () {},
                    title: "Personal Information",
                  ),
                  const SizedBox(height: 12),
                  InformationItem(
                    titleText: "User Ref#",
                    valueText: state.visitorDetails.data!.id.toString(),
                  ),
                  InformationItem(
                    titleText: "Last Name",
                    valueText: state.visitorDetails.data!.name ?? '',
                  ),
                  InformationItem(
                    titleText: "Designation",
                    valueText: state.visitorDetails.data!.designation ?? '',
                  ),
                  InformationItem(
                    titleText: "Department",
                    valueText: state.visitorDetails.data!.department ?? '',
                  ),
                  InformationItem(
                    titleText: "User Id",
                    valueText: state.visitorDetails.data!.code ?? '',
                  ),
                  InformationItem(
                    titleText: "Phone",
                    valueText: state.visitorDetails.data!.mobile ?? '',
                  ),
                  InformationItem(
                    titleText: "Email",
                    valueText: state.visitorDetails.data!.email ?? '',
                  ),
                  const SizedBox(height: 30),
                  const Ttile(
                    title: "Company Information",
                  ),
                  const SizedBox(height: 12),
                  InformationItem(
                    titleText: "Company",
                    valueText: state.visitorDetails.data!.company != null
                        ? state.visitorDetails.data!.company!.name ?? ""
                        : "",
                  ),
                  InformationItem(
                    titleText: "Address",
                    valueText: state.visitorDetails.data!.company != null
                        ? state.visitorDetails.data!.company!.address ?? ""
                        : "",
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0XFFEEEEEE),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextB(
                              text: "This Month",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            InkWell(
                              onTap: () {
                                bloc.add(GoToPerformanceReport());
                              },
                              child: const TextB(
                                text: "Performance Report",
                                fontSize: 14,
                                fontColor: bGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          TextB(
                            text:
                                "${state.visitorDetails.data!.name}'s activity",
                            fontSize: 14,
                            fontColor: bDarkGray,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              bloc.add(GoToVisitorVisitsScreen(
                                  userDetails: state.visitorDetails));
                            },
                            child: const TextB(
                              text: "View all visits",
                              fontSize: 14,
                              fontColor: bBlue,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: (size.width - 40) / 3 * 2,
                        width: size.width - 40,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.chart.charts != null
                            ? BarChartB(
                                chart: state.chart,
                                theme: ChartTheme.white,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  //const DropDownCont(),
                  const SizedBox(height: 20),
                ],
              )
            : const SizedBox(),
      );
    });
  }
}

class DropDownCont extends StatefulWidget {
  const DropDownCont({super.key});

  @override
  State<DropDownCont> createState() => _DropDownContState();
}

class _DropDownContState extends State<DropDownCont> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    const text =
        "asdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdf asdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdfasdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdfasdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdfasdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdfasdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdfasdfsdf asfsadf asdfsadf asdfasdf asdfsdf asdfsadf asdfsadf asdfsdf 22";

    final TextPainter textPainter = TextPainter(
      text: const TextSpan(text: text),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    final height = textPainter.height *
        (textPainter.width / (MediaQuery.of(context).size.width - 40)).ceil();

    return Column(
      children: [
        AnimatedContainer(
          clipBehavior: Clip.antiAlias,
          height: expand ? height : 32,
          decoration: const BoxDecoration(color: Colors.transparent),
          duration: const Duration(milliseconds: 500),
          child: const TextB(text: text),
        ),
        GestureDetector(
          child: const TextB(text: "Click"),
          onTap: () {
            setState(() {
              expand = !expand;
            });
          },
        ),
      ],
    );
  }
}
