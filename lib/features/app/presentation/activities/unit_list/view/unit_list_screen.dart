import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/unit_list/bloc/unit_list_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/unit_list/widget/unit_item.dart';

class UnitListScreen extends StatelessWidget {
  const UnitListScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const UnitListScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UnitListBloc(getIt<ApiRepo>(), getIt<LocalStorageRepo>(),
          getIt<IFlutterNavigator>()),
      child: const UnitListView(),
    );
  }
}

class UnitListView extends StatelessWidget {
  const UnitListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UnitListBloc>();
    final scroll = ScrollController();

    return BlocBuilder<UnitListBloc, UnitListState>(builder: (context, state) {
      scroll.addListener(() {
        if (scroll.position.pixels == scroll.position.maxScrollExtent) {
          if (state.units.meta != null && !state.incrementLoader) {
            bloc.add(PageIncrement());
          }
        }
      });
      return CommonBodyB(
        appBarTitle: "Units",
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.dashboard.name));
            },
          )
        ],
        bottomSection: ButtonB(
          shadow: true,
          text: 'Add Unit',
          press: () {
            bloc.add(GoToAddNewUnit());
          },
        ),
        child: Material(
          color: bWhite,
          child: ListView(
            padding: EdgeInsets.zero,
            controller: scroll,
            children: [
              const SizedBox(height: 20),
              const TextB(
                text: "Your permitted unit lists here",
                fontSize: 18,
                fontColor: bDark,
              ),
              const SizedBox(height: 20),
              state.units.data != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0XFFE1E1E3)),
                      ),
                      child: Column(
                        children: [
                          ...List.generate(
                            state.units.data!.length,
                            (index) => UnitItem(
                              units: state.units,
                              itemIndex: index,
                              press: (UnitData unit) {
                                bloc.add(
                                  GoToUnitDetails(unitData: unit),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
              state.units.meta != null
                  ? state.currentPage < state.units.meta!.lastPage!
                      ? Container(
                          height: 30,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: state.incrementLoader
                              ? const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator())
                              : const SizedBox())
                      : Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const TextB(
                              text: "You've reached the end of the list"),
                        )
                  : const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
