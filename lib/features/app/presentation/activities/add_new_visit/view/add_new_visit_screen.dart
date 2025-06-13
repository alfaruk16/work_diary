import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_visit/bloc/add_new_visit_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';

class AddNewVisitScreen extends StatelessWidget {
  const AddNewVisitScreen({Key? key, this.visitorId}) : super(key: key);

  final int? visitorId;

  static Route<dynamic> route({int? visitorId}) => MaterialPageRoute<dynamic>(
        builder: (_) => AddNewVisitScreen(visitorId: visitorId),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddNewVisitBloc(getIt<IFlutterNavigator>(),
          getIt<ApiRepo>(), getIt<LocalStorageRepo>())
        ..add(GetCompanyIdEvent(visitorId: visitorId)),
      child: AddNewVisitView(),
    );
  }
}

class AddNewVisitView extends StatelessWidget {
  AddNewVisitView({Key? key}) : super(key: key);

  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  final visitPlanNameFocusNode = FocusNode();
  final numberOfDayFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddNewVisitBloc>();

    return BlocBuilder<AddNewVisitBloc, AddNewVisitState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "New Visit",
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "All Visit Plan"),
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
          text: "Save Visit",
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
                controller: dateController,
                onTouch: () {
                  datePicker(
                    context,
                    minDate: DateTime.now(),
                    date: (date) {
                      bloc.add(SelectDate(
                          date: date.toString(),
                          dateController: dateController));
                    },
                  );
                },
                isReadOnly: true,
                isMandatory: true,
                suffixIcon: const Icon(
                  Icons.date_range,
                  size: 30,
                  color: bGray,
                ),
                fieldTitle: "Date",
                hintText: 'yyyy-MM-dd',
                focusNode: dateFocusNode,
                onChanged: (value) {},
                errorText: state.forms == Forms.invalid && state.date.isEmpty
                    ? 'Select a Date'
                    : '',
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownSearchB(
                    label: 'Assignee',
                    items: state.visitorList,
                    loading: state.assigneeLoading,
                    dropDownValue: state.visitorId,
                    hint: 'Select',
                    selected: (id) {
                      bloc.add(VisitorSelected(visitorId: id));
                    },
                  ),
                  if (state.visitors.data != null &&
                      state.visitors.data!.isNotEmpty)
                    const SizedBox(height: 3),
                  if (state.visitors.data != null &&
                      state.visitors.data!.isNotEmpty)
                    const TextB(
                      text:
                          "Please select assignee, if you want to create this visit for others",
                      fontSize: 12,
                      fontColor: bBlue,
                    ),
                  const SizedBox(height: 20),
                ],
              ),
              DropdownSearchB(
                label: "Zone",
                items: state.zonesList,
                setState: state.setZone,
                dropDownValue: state.zoneIndex,
                loading: state.zoneLoading,
                selected: (index) {
                  bloc.add(GetZoneIndexEvent(zoneIndex: index));
                },
                errorText: state.forms == Forms.invalid && state.zoneIndex == -1
                    ? 'Select a Zone'
                    : '',
                isMandatory: true,
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
