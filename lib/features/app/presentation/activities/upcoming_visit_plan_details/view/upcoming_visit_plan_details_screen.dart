import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/upcoming_visit_plan_details/bloc/bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class UpcomingVisitPlanDetailsScreen extends StatelessWidget {
  const UpcomingVisitPlanDetailsScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
    builder: (_) => const UpcomingVisitPlanDetailsScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpcomingVisitPlanDetailsBloc(),
      child: const UpcomingVisitPlanDetailsView(),
    );
  }
}

class UpcomingVisitPlanDetailsView extends StatelessWidget {
  const UpcomingVisitPlanDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<UpcomingVisitPlanDetailsBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<
      UpcomingVisitPlanDetailsBloc,
      UpcomingVisitPlanDetailsState
    >(
      builder: (context, state) {
        return CommonBodyB(
          appBarTitle: "Completed Visit Plan",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0XFFE9F0FF),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const TextB(
                  text: "This visit Plan is not yet started",
                  textStyle: bHeadline6,
                  fontColor: bBlack,
                  alignMent: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              DottedBorder(
                options: RectDottedBorderOptions(
                  color: bGreen,
                  strokeWidth: 1.5,
                  dashPattern: const [4, 3],
                  padding: const EdgeInsets.all(1),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0XFFFFFBED),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextB(
                        text:
                            "This visit plan is created for 26 jul 2022 you don,t able to completed right now",
                        fontColor: bDark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
