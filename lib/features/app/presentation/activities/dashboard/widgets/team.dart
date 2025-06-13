import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/visitor_card.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/bloc/bloc.dart';

class MyTeam extends StatelessWidget {
  const MyTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      final bloc = context.read<DashboardBloc>();
      return Column(
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextB(
                text: "My Team",
                fontColor: bBlack,
                textStyle: bHeadline5,
              ),
              if (state.dashboardSupervisor.data!.visitorsCount! > 3)
                InkWell(
                  onTap: () {
                    bloc.add(GoToVisitorListScreen());
                  },
                  child: const TextB(
                    text: "See all",
                    fontColor: bBlue,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.visitors.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 170),
            itemBuilder: (BuildContext context, int index) {
              return VisitorCard(
                isIconBtn: true,
                image: state.visitors.data![index].avatar,
                pressToDetails: () {
                  bloc.add(
                      GoToVisitorDetails(visitor: state.visitors.data![index]));
                },
                pressToAddVisit: () {
                  bloc.add(AssignToNewVisit(
                      visitorId: state.visitors.data![index].id!));
                },
                name: state.visitors.data![index].name,
                designation: state.visitors.data![index].designation,
              );
            },
          ),
        ],
      );
    });
  }
}
