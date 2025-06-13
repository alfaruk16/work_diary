import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/big_camera.dart';
import 'package:work_diary/core/widgets/date_picker.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/core/widgets/grid_view_file_image.dart';
import 'package:work_diary/core/widgets/network_image.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';
import 'package:work_diary/features/app/presentation/activities/form/bloc/bloc.dart';

class FormItem extends StatelessWidget {
  const FormItem({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormsBloc>();

    return BlocBuilder<FormsBloc, FormsState>(builder: (context, state) {
      return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: state.form.data!.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            String groupName = '';
            if (state.form.data![index]!.fieldGroupId != null &&
                (index == 0 ||
                    state.form.data![index]!.groupName !=
                        state.form.data![index - 1]!.groupName)) {
              groupName = state.form.data![index]!.groupName!;
            }
            final formData = state.form.data![index];
            return Container(
              padding: EdgeInsets.only(
                  left: formData!.parentId != null ? 20 : 0,
                  top: formData.parentId == null &&
                          formData.inputType != InputType.hidden.name
                      ? 5
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (groupName != '')
                    Container(
                        padding: EdgeInsets.only(
                            top: formData.inputType == InputType.hidden.name
                                ? 0
                                : 8,
                            bottom: formData.inputType == InputType.hidden.name
                                ? 0
                                : 5),
                        child: TextB(
                            text: groupName, fontWeight: FontWeight.w600)),
                  if (formData.inputType == InputType.text.name)
                    TextFieldB(
                      labelText: formData.name,
                      labelSize: formData.parentId != null ? 14 : 16,
                      focusNode: state.focusList[index],
                      controller: state.controllerList[index],
                      onChanged: (value) {
                        bloc.add(FormItemChanged(index: index, value: value));
                        bloc.add(CallFormula(
                            fieldId: formData.id!.toString(),
                            fieldIndex: index,
                            currentIndex: index));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.valueList[index] == ''
                          ? state.errorText[index]
                          : '',
                      textInputType: TextInputType.text,
                      isReadOnly: formData.isReadonly ?? false,
                      isMandatory: formData.isRequired!,
                      loading: state.loadingList[index],
                    )
                  else if (formData.inputType == InputType.hidden.name)
                    TextFieldB(
                      visibility: false,
                      labelText: formData.name,
                      labelSize: formData.parentId != null ? 14 : 16,
                      focusNode: state.focusList[index],
                      controller: state.controllerList[index],
                      onChanged: (value) {
                        bloc.add(FormItemChanged(index: index, value: value));
                        bloc.add(CallFormula(
                            fieldId: formData.id!.toString(),
                            fieldIndex: index,
                            currentIndex: index));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.valueList[index] == ''
                          ? state.errorText[index]
                          : '',
                      textInputType: TextInputType.text,
                      isReadOnly: formData.isReadonly ?? false,
                      isMandatory: formData.isRequired!,
                      loading: state.loadingList[index],
                    )
                  else if (formData.inputType == InputType.number.name)
                    TextFieldB(
                      labelText: formData.name,
                      labelSize: formData.parentId != null ? 14 : 16,
                      focusNode: state.focusList[index],
                      controller: state.controllerList[index],
                      onChanged: (value) {
                        bloc.add(FormItemChanged(index: index, value: value));
                        bloc.add(CallFormula(
                            fieldId: formData.id!.toString(),
                            fieldIndex: index,
                            currentIndex: index));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.valueList[index] == ''
                          ? state.errorText[index]
                          : '',
                      textInputType: TextInputType.number,
                      isReadOnly: formData.isReadonly ?? false,
                      isMandatory: formData.isRequired!,
                      loading: state.loadingList[index],
                    )
                  else if (formData.inputType == InputType.date.name)
                    TextFieldB(
                        labelSize: formData.parentId != null ? 14 : 16,
                        focusNode: state.focusList[index],
                        controller: state.controllerList[index],
                        isDate: true,
                        onTouch: () {
                          datePicker(
                            context,
                            date: (date) {
                              bloc.add(DateChanged(index: index, date: date));
                            },
                          );
                        },
                        isReadOnly: formData.isReadonly ?? false,
                        suffixIcon: const Icon(
                          Icons.date_range,
                          size: 30,
                          color: bGray,
                        ),
                        fieldTitle: formData.name,
                        hintText:
                            DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        onChanged: (value) {},
                        errorText: state.forms == Forms.invalid &&
                                state.valueList[index] == ''
                            ? state.errorText[index]
                            : '',
                        isMandatory: formData.isRequired!)
                  else if (formData.inputType == InputType.dropdown.name)
                    DropdownSearchB(
                        label: formData.name!,
                        padding: formData.parentId != null ? 0 : 5,
                        labelSize: formData.parentId != null ? 14 : 16,
                        hint: 'Select',
                        items: state.dropDownList[index],
                        setState: state.dropDownSet,
                        loading: state.loadingList[index],
                        dropDownValue: getDropDownValue(
                            state.dropDownList[index], state.valueList[index]),
                        selected: (value) {
                          final name =
                              getDropDownName(state.dropDownList[index], value);
                          bloc.add(GetChildren(
                              parentValue: value,
                              fieldIndex: index,
                              childrenCount: formData.childrenCount!,
                              parenId: formData.parentId,
                              id: formData.id!,
                              name: name));
                          bloc.add(FormItemChanged(index: index, value: name));
                        },
                        errorText: state.forms == Forms.invalid &&
                                state.valueList[index] == ''
                            ? state.errorText[index]
                            : '',
                        isMandatory: formData.isRequired!,
                        isMultiple: formData.isMultiple!)
                  else if (formData.inputType == InputType.image.name)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigCamera(
                          tittle: formData.name!,
                          labelSize: formData.parentId != null ? 14 : 16,
                          padding: formData.parentId != null ? 0 : 5,
                          press: () {
                            bloc.add(PickImage(index: index));
                          },
                          errorText: state.forms == Forms.invalid &&
                                  state.valueList[index] == ''
                              ? state.errorText[index]
                              : '',
                        ),
                        TextB(
                            text: formData.isMultiple!
                                ? '* Multiple ${formData.name} allowed'
                                : '* Multiple ${formData.name} is not allowed',
                            textStyle: const TextStyle(
                                fontSize: 12, color: bDarkGray)),
                        state.images[index].isNotEmpty
                            ? GridViewFileImageB(
                                images: state.images[index],
                                cancel: (imageIndex) {
                                  bloc.add(CancelAnImage(
                                      filedIndex: index,
                                      imageIndex: imageIndex));
                                },
                              )
                            : state.prevImages[index].isNotEmpty ? Container(
                                padding: const EdgeInsets.only(top: 10),
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: NetworkImageB(
                                      imageUrl: state.prevImages[index],
                                    )),
                              ): const SizedBox(height: 0),
                      ],
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          });
    });
  }

  getDropDownName(List<DropdownItem> dropDownList, int id) {
    for (int i = 0; i < dropDownList.length; i++) {
      if (dropDownList[i].value == id) {
        return dropDownList[i].name;
      }
    }
  }

  int? getDropDownValue(List<DropdownItem> dropDownList, String name) {
    for (int i = 0; i < dropDownList.length; i++) {
      if (dropDownList[i].name == name) {
        return dropDownList[i].value;
      }
    }
    return null;
  }
}
