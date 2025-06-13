import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/big_camera.dart';
import 'package:work_diary/core/widgets/date_picker.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/core/widgets/grid_view_file_image.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';
import 'package:work_diary/features/app/presentation/activities/slot/bloc/bloc.dart';

class FormItem extends StatelessWidget {
  const FormItem(
      {super.key,
      required this.formData,
      required this.index,
      required this.formIndex,
      this.groupName = ''});

  final FormData formData;
  final int index;
  final int formIndex;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SlotBloc>();

    return BlocBuilder<SlotBloc, SlotState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (groupName != '')
            Container(
                padding: const EdgeInsets.only(top: 8),
                child: TextB(text: groupName, fontWeight: FontWeight.w600)),
          if (formData.inputType == InputType.text.name)
            TextFieldB(
                labelText: formData.displayName,
                focusNode: state.formList.formItems[formIndex].focusList[index],
                controller:
                    state.formList.formItems[formIndex].controllerList[index],
                onChanged: (value) {
                  bloc.add(FormItemChanged(
                      index: index, value: value, formIndex: formIndex));
                  bloc.add(CallFormula(
                      fieldId: formData.id!.toString(),
                      fieldIndex: index,
                      formIndex: formIndex));
                },
                errorText: state.forms == Forms.invalid &&
                        state.formList.formItems[formIndex].valueList[index] ==
                            ''
                    ? state.formList.formItems[formIndex].errorText[index]
                    : '',
                textInputType: TextInputType.text,
                isReadOnly: formData.isReadonly ?? false)
          else if (formData.inputType == InputType.number.name)
            TextFieldB(
                labelText: formData.displayName,
                focusNode: state.formList.formItems[formIndex].focusList[index],
                controller:
                    state.formList.formItems[formIndex].controllerList[index],
                onChanged: (value) {
                  bloc.add(FormItemChanged(
                      index: index, value: value, formIndex: formIndex));
                  bloc.add(CallFormula(
                      fieldId: formData.id!.toString(),
                      fieldIndex: index,
                      formIndex: formIndex));
                },
                errorText: state.forms == Forms.invalid &&
                        state.formList.formItems[formIndex].valueList[index] ==
                            ''
                    ? state.formList.formItems[formIndex].errorText[index]
                    : '',
                textInputType: TextInputType.number,
                isReadOnly: formData.isReadonly ?? false)
          else if (formData.inputType == InputType.date.name)
            TextFieldB(
              focusNode: state.formList.formItems[formIndex].focusList[index],
              controller:
                  state.formList.formItems[formIndex].controllerList[index],
              onTouch: () {
                datePicker(
                  context,
                  date: (date) {
                    bloc.add(DateChanged(
                        index: index, date: date, formIndex: formIndex));
                  },
                );
              },
              isReadOnly: formData.isReadonly ?? false,
              suffixIcon: const Icon(
                Icons.date_range,
                size: 30,
                color: bGray,
              ),
              fieldTitle: formData.displayName,
              hintText: DateFormat("yyyy-MM-dd").format(DateTime.now()),
              onChanged: (value) {},
              errorText: state.forms == Forms.invalid &&
                      state.formList.formItems[formIndex].valueList[index] == ''
                  ? state.formList.formItems[formIndex].errorText[index]
                  : '',
            )
          else if (formData.inputType == InputType.dropdown.name)
            DropdownSearchB(
              label: formData.displayName!,
              items: [
                const DropdownItem(name: 'Select', value: -1),
                ...state.formList.formItems[formIndex].dropDownList[index]
              ],
              selected: (List<String> objectives) {
                bloc.add(FormItemChanged(
                    index: index,
                    value: objectives.toString(),
                    formIndex: formIndex));
              },
              errorText: state.forms == Forms.invalid &&
                      state.formList.formItems[formIndex].valueList[index] == ''
                  ? state.formList.formItems[formIndex].errorText[index]
                  : '',
              isMultiple: formData.isMultiple!,
            )
          else if (formData.inputType == InputType.image.name)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigCamera(
                    tittle: formData.displayName!,
                    press: () {
                      bloc.add(PickImage(index: index, formIndex: formIndex));
                    },
                    errorText: state.forms == Forms.invalid &&
                            state.formList.formItems[formIndex]
                                    .valueList[index] ==
                                ''
                        ? state.formList.formItems[formIndex].errorText[index]
                        : ''),
                TextB(
                    text: formData.isMultiple!
                        ? '* Multiple ${formData.displayName} allowed'
                        : '* Multiple ${formData.displayName} not allowed',
                    textStyle: const TextStyle(fontSize: 12, color: bDarkGray)),
                GridViewFileImageB(
                  images: state.formList.formItems[formIndex].images[index],
                ),
              ],
            ),
          const SizedBox(height: 10),
        ],
      );
    });
  }

  getDropDownName(List<DropdownItem> dropDownList, int id) {
    for (int i = 0; i < dropDownList.length; i++) {
      if (dropDownList[i].value == id) {
        return dropDownList[i].name;
      }
    }
  }
}
