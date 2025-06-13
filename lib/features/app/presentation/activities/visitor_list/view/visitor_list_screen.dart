import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/visitor_list/bloc/visitor_list_bloc.dart';

class VisitorListScreen extends StatelessWidget {
  const VisitorListScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const VisitorListScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisitorListBloc(getIt<ApiRepo>(),
          getIt<LocalStorageRepo>(), getIt<IFlutterNavigator>()),
      child: const VisitorListView(),
    );
  }
}

class VisitorListView extends StatelessWidget {
  const VisitorListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VisitorListBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<VisitorListBloc, VisitorListState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "My Team",
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
        child: state.visitors.data != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 15),
                  TextB(
                    text:
                        "Number of visitors: ${state.visitors.data!.length.toString().padLeft(2, "0")}",
                    fontSize: 20,
                    fontColor: bBlack,
                  ),
                  const SizedBox(height: 30),
                  if (state.visitors.data != null)
                    GridView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.visitors.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: size.width / 5 * 2.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return VisitorCard(
                          avatarSize: 101,
                          image: state.visitors.data![index].avatar,
                          pressToDetails: () {
                            bloc.add(GoToDetails(
                                visitor: state.visitors.data![index]));
                          },
                          pressToAddVisit: () {
                            bloc.add(AssignVisit(
                                visitorId: state.visitors.data![index].id!));
                          },
                          name: state.visitors.data![index].name,
                          designation: state.visitors.data![index].designation,
                        );
                      },
                    ),
                  const SizedBox(height: 30),
                ],
              )
            : state.visitors.data != null && state.visitors.data!.isEmpty
                ? const Center(
                    child: TextB(
                      text: 'Data not found',
                    ),
                  )
                : const SizedBox(),
      );
    });
  }
}
