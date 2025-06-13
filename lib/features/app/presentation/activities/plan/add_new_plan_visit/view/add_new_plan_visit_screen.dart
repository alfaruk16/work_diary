import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/features/app/presentation/activities/plan/add_new_plan_visit/bloc/add_new_plan_visit_bloc.dart';

class AddNewPlanVisitScreen extends StatelessWidget {
  const AddNewPlanVisitScreen({Key? key, this.planId}) : super(key: key);
  final int? planId;

  static Route<dynamic> route({int? planId}) => MaterialPageRoute<dynamic>(
        builder: (_) => AddNewPlanVisitScreen(planId: planId),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddNewPlanVisitBloc(getIt<IFlutterNavigator>(),
          getIt<ApiRepo>(), getIt<LocalStorageRepo>())
        ..add(GetCompanyIdEvent(planId: planId)),
      child: AddNewPlanVisitView(),
    );
  }
}

class AddNewPlanVisitView extends StatelessWidget {
  AddNewPlanVisitView({Key? key}) : super(key: key);

  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  final visitPlanNameFocusNode = FocusNode();
  final numberOfDayFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddNewPlanVisitBloc>();

    return BlocBuilder<AddNewPlanVisitBloc, AddNewPlanVisitState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "New Visit Plan",
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "New Plan"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.createNewPlan.name));
            },
          ),
          PopupMenuItem(
            child: const TextB(text: "All Plan"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.allVisitPlan.name));
            },
          ),
          PopupMenuItem(
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.dashboard.name));
            },
          )
        ],
        bottomSection: ButtonB(
          press: () {
            bloc.add(CreateVisitEvent());
          },
          text: "Save Visit Plan",
          bgColor: bBlue,
          textColor: bWhite,
          loading: state.loading,
        ),
        child: Material(
          color: bWhite,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 25),
              const TextB(
                text: "Fill out the form below to create new visit",
                fontSize: 14,
                fontColor: bBlue,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DropdownSearchB(
                      label:
                          "Plan${state.planDate.isNotEmpty ? " (${state.planDate})" : ''}",
                      items: state.planList,
                      setState: state.resetPlan,
                      dropDownValue: state.selectedPlan,
                      loading: state.planLoading,
                      selected: (id) {
                        bloc.add(PlanSelected(planId: id));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.selectedPlan == -1
                          ? 'Select a Plan'
                          : '',
                      isMandatory: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bloc.add(GoToCreateNewPlan());
                    },
                    child: Container(
                      height: 48,
                      margin: const EdgeInsets.only(top: 24, left: 8),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0XFF93F5E8)),
                          color: const Color(0XFFF1FDFA),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.add_circle,
                        color: Color(0XFF11B09B),
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              DropdownSearchB(
                  label: state.unitMessage,
                  setState: state.setUnits,
                  items: state.unitList,
                  loading: state.unitLoading,
                  selected: (index) {
                    bloc.add(UnitSelected(unitIndex: index));
                  },
                  errorText: state.forms == Forms.invalid &&
                          state.currentUnitIndex == -1
                      ? 'Select a ${state.unitMessage}'
                      : '',
                  isMandatory: true),
              const SizedBox(height: 20),
              if (state.unitType.data != null &&
                  state.unitType.data!.length > 1)
                Column(
                  children: [
                    DropdownSearchB(
                        label: '${state.unitMessage} Type',
                        setState: state.setUnitType,
                        items: state.unitTypeList,
                        loading: state.unitTypeLoading,
                        selected: (index) {
                          bloc.add(UnitTypeSelected(unitIndex: index));
                        },
                        errorText: state.forms == Forms.invalid &&
                                state.selectedUnitType == -1
                            ? 'Select a ${state.unitMessage} Type'
                            : '',
                        isMandatory: true),
                    const SizedBox(height: 20),
                  ],
                ),
              DropdownSearchB(
                label: "Objective",
                items: state.visitObjectList,
                loading: state.objectiveLoading,
                selected: (objectives) {
                  bloc.add(GetObjEvent(objectives: objectives));
                },
                errorText:
                    state.forms == Forms.invalid && state.selectedObj.isEmpty
                        ? 'Select Objective'
                        : '',
                isMultiple: true,
                isMandatory: true,
              ),
              const SizedBox(height: 20),
              TextFieldB(
                fieldTitle: "Note",
                hintText: "Ex: Visit note here",
                onChanged: (value) {
                  bloc.add(VisitNoteChangedEvent(visitNote: value));
                },
                focusNode: numberOfDayFocusNode,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
