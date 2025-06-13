import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/profile_header.dart';
import 'package:work_diary/features/app/presentation/activities/todays_visit/widget/plan_list.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_visits/bloc/visitor_visits_bloc.dart';

class VisitorVisitsScreen extends StatelessWidget {
  const VisitorVisitsScreen({Key? key, required this.userDetails})
      : super(key: key);
  final UserDetails userDetails;

  static Route<dynamic> route({required UserDetails userDetails}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => VisitorVisitsScreen(userDetails: userDetails),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisitorVisitsBloc(getIt<ApiRepo>(),
          getIt<LocalStorageRepo>(), getIt<IFlutterNavigator>())
        ..add(GetDataById(userDetails: userDetails)),
      child: const VisitorVisitsView(),
    );
  }
}

class VisitorVisitsView extends StatelessWidget {
  const VisitorVisitsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VisitorVisitsBloc>();
    //final size = MediaQuery.of(context).size;
    final scroll = ScrollController();

    return BlocBuilder<VisitorVisitsBloc, VisitorVisitsState>(
        builder: (context, state) {
      scroll.addListener(() {
        if (scroll.position.pixels == scroll.position.maxScrollExtent) {
          bloc.add(PageIncrement());
        }
      });
      return CommonBodyB(
        appBarTitle: "User Visit List",
        loading: state.isLoading,
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
                controller: scroll,
                children: [
                  ProfileHeader(
                    size: 110,
                    image: state.visitorDetails.data!.avatar ?? photoPng,
                    isRowHeader: false,
                    userName: state.visitorDetails.data!.name,
                    title: state.visitorDetails.data!.designation,
                  ),
                  state.visits.data != null
                      ? PlanList(
                          isLoading: state.isLoading,
                          isEndList: state.isEndList,
                          planList: state.visits.data!,
                          isSupervisor: state.isSupervisor,
                          goToDetailsScreen:
                              (String visitType, VisitData visitData) {
                            bloc.add(GoToPlanList(
                                planType: visitType, visitData: visitData));
                          },
                          changeStatus: (int id, String status) {
                            bloc.add(GetComments(id: id, status: status));
                          },
                        )
                      : const SizedBox(),
                ],
              )
            : const SizedBox(),
      );
    });
  }
}
