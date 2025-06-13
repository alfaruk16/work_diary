import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/date_picker.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/add_new_emergency_issue/bloc/add_new_emergency_issue_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class AddNewEmergencyIssueScreen extends StatelessWidget {
  const AddNewEmergencyIssueScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const AddNewEmergencyIssueScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddNewEmergencyIssueBloc(getIt<IFlutterNavigator>(),
          getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
      child: AddNewEmergencyIssueView(),
    );
  }
}

class AddNewEmergencyIssueView extends StatelessWidget {
  AddNewEmergencyIssueView({Key? key}) : super(key: key);
  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  final noteFocusnode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddNewEmergencyIssueBloc>();

    return BlocBuilder<AddNewEmergencyIssueBloc, AddNewEmergencyIssueState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Add new emergency issue",
        menuList: [
          PopupMenuItem(
            value: PopUpMenu.allEmergencyIssue.name,
            child: const TextB(text: "All Emergency Issue"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.allEmergencyIssue.name));
            },
          ),
        ],
        bottomSection: ButtonB(
          press: () {
            bloc.add(CreateEmergencyIssue());
          },
          text: "Save Emergency Issue",
          bgColor: bSkyBlue,
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
                text: "Please Create new Emergency Issue",
                fontSize: 12,
                fontColor: bBlue,
              ),
              const SizedBox(height: 15),
              DropdownSearchB(
                  label: "Objective",
                  items: state.visitObjectList,
                  loading: state.objectiveLoading,
                  selected: (List<String> objectives) {
                    bloc.add(GetObjEvent(objectives: objectives));
                  },
                  errorText:
                      state.forms == Forms.invalid && state.selectedObj.isEmpty
                          ? 'Select Objective'
                          : '',
                  isMultiple: true),
              const SizedBox(height: 15),
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
                suffixIcon: const Icon(
                  Icons.date_range,
                  size: 30,
                  color: bGray,
                ),
                fieldTitle: "Date",
                hintText: 'yyyy-mm-dd',
                focusNode: dateFocusNode,
                onChanged: (value) {},
                errorText: state.forms == Forms.invalid && state.date.isEmpty
                    ? 'Select a Date'
                    : '',
              ),
              const SizedBox(height: 15),
              const TextB(
                text: "Zone",
                fontSize: 16,
              ),
              DropdownSearchB(
                items: state.zonesList,
                loading: state.zoneLoading,
                selected: (index) {
                  bloc.add(GetZoneIndexEvent(zoneIndex: index));
                },
                errorText: state.forms == Forms.invalid && state.zoneIndex == -1
                    ? 'Select a Zone'
                    : '',
              ),
              const SizedBox(height: 20),
              const TextB(
                text: "Unit",
                fontSize: 16,
              ),
              DropdownSearchB(
                setState: state.setUnits,
                items: state.unitList,
                loading: state.unitLoading,
                selected: (index) {
                  bloc.add(UnitSelected(unitIndex: index));
                },
                errorText:
                    state.forms == Forms.invalid && state.currentUnitId == -1
                        ? 'Select a Unit'
                        : '',
              ),
              const SizedBox(height: 20),
              const TextB(
                text: "Unit Type",
                fontSize: 16,
              ),
              DropdownSearchB(
                setState: state.setUnitType,
                items: state.unitTypeList,
                loading: state.unitTypeLoading,
                selected: (index) {
                  bloc.add(UnitTypeSelected(unitIndex: index));
                },
                errorText:
                    state.forms == Forms.invalid && state.selectedUnitType == -1
                        ? 'Select a Unit Type'
                        : '',
              ),
              const SizedBox(height: 20),
              if (state.visitorList.length > 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextB(
                      text: "Assign visitor",
                      fontSize: 16,
                    ),
                    DropdownSearchB(
                      setState: state.setVisitors,
                      items: state.visitorList,
                      hint: 'Me',
                      selected: (id) {
                        bloc.add(VisitorSelected(visitorId: id));
                      },
                    ),
                    const SizedBox(height: 3),
                    const TextB(
                      text:
                          "For your own visit, you don't need to select anyone for assignee.",
                      fontSize: 12,
                      fontColor: bBlue,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              TextFieldB(
                fieldTitle: "Note",
                hintText: "Ex: task note here",
                maxLines: 3,
                onChanged: (value) {
                  bloc.add(TaskNote(taskNote: value));
                },
                focusNode: noteFocusnode,
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      );
    });
  }
}
