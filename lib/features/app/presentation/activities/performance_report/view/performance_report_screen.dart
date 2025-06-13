import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/performance_report/bloc/performance_report_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/performance_report/widgets/header.dart';
import 'package:work_diary/features/app/presentation/activities/performance_report/widgets/performance_item.dart';

class PerformanceReportScreen extends StatelessWidget {
  const PerformanceReportScreen({Key? key, required this.visitorDetails})
      : super(key: key);
  final UserDetails visitorDetails;

  static Route<dynamic> route({required UserDetails visitor}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => PerformanceReportScreen(visitorDetails: visitor),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PerformanceReportBloc(getIt<ApiRepo>(),
          getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
        ..add(GetDetailsById(visitorInfo: visitorDetails)),
      child: const PerformanceReportView(),
    );
  }
}

class PerformanceReportView extends StatelessWidget {
  const PerformanceReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PerformanceReportBloc>();

    return BlocBuilder<PerformanceReportBloc, PerformanceReportState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Performance History",
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
                  const SizedBox(height: 20),
                  if (state.performance.data != null)
                    PerformanceHeader(
                      image: state.visitorDetails.data!.avatar!,
                      performanceReport: state.performance,
                      selectedMonth: state.selectedMonth,
                      months: state.monthList,
                      selected: (month) {
                        bloc.add(SelectedMonth(month: month));
                      },
                    ),
                  const SizedBox(height: 20),
                  if (state.performance.data != null &&
                      state.performance.data!.details!.isNotEmpty)
                    const TextB(
                        text: 'Your visit Target for this month',
                        fontColor: Colors.black),
                  const SizedBox(height: 8),
                  if (state.performance.data != null)
                    ListView.builder(
                        itemCount: state.performance.data!.details!.length,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PerformanceItem(
                              detail: state.performance.data!.details![index]);
                        })
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
