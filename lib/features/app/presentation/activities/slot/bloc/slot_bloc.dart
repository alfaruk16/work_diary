import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/form_validator/validator.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/snackbar/show_snackbar.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/slot.dart';
import 'package:work_diary/features/app/data/models/source.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';
import 'package:work_diary/features/app/domain/entities/slot_response.dart';
import 'package:work_diary/features/app/domain/entities/source_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/debounce.dart';
import 'package:function_tree/function_tree.dart';

part 'slot_event.dart';
part 'slot_state.dart';

class SlotBloc extends Bloc<SlotEvent, SlotState> {
  SlotBloc(this._flutterNavigator, this._imagePicker, this._apiRepo)
      : super(const SlotState()) {
    on<GoToOngoingVisitPlanScreen>(_goToOnGoingVisitPlan);
    on<FormItemChanged>(_formItemChanged);
    on<FormFieldChanged>(_formFieldChanged);
    on<DateChanged>(_dateChanged);
    on<GetVisitDetails>(_getVisitDetails);
    on<GetForm>(_getForm);
    on<AddSource>(_addSource);
    on<AddSourceObject>(_addSourceObject);
    on<CallFormula>(_callFormula);
    on<SolveFormula>(_solveFormula);
    on<SaveSlot>(_saveSlot);
    on<PickImage>(_pickImage);
  }

  final IFlutterNavigator _flutterNavigator;
  final ImagePicker _imagePicker;
  final ApiRepo _apiRepo;

  FutureOr<void> _goToOnGoingVisitPlan(
      GoToOngoingVisitPlanScreen event, Emitter<SlotState> emit) {
    _flutterNavigator.pop();
  }

  FutureOr<void> _formItemChanged(
      FormItemChanged event, Emitter<SlotState> emit) {
    final formItems = state.formList.formItems;
    formItems[event.formIndex].valueList[event.index] = event.value;

    emit(state.copyWith(formList: FormViewList(formItems: formItems)));
  }

  FutureOr<void> _formFieldChanged(
      FormFieldChanged event, Emitter<SlotState> emit) async {
    final formItems = state.formList.formItems;
    formItems[event.formIndex].valueList[event.index] = event.value;
    formItems[event.formIndex].controllerList[event.index].text = event.value;

    emit(state.copyWith(formList: FormViewList(formItems: formItems)));

    if (event.index == state.prevIndex) {
      debounce.call(() {
        add(CallFormula(
            fieldId: state.form.data![event.index].id!.toString(),
            fieldIndex: event.index,
            formIndex: event.formIndex));
      });
    } else {
      add(CallFormula(
          fieldId: state.form.data![event.index].id!.toString(),
          fieldIndex: event.index,
          formIndex: event.formIndex));
    }
    emit(state.copyWith(prevIndex: event.index));
  }

  FutureOr<void> _dateChanged(DateChanged event, Emitter<SlotState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(event.date);

    final formItems = state.formList.formItems;
    formItems[event.formIndex].valueList[event.index] = date;
    formItems[event.formIndex].controllerList[event.index].text = date;

    emit(state.copyWith(formList: FormViewList(formItems: formItems)));
  }

  Future<FutureOr<void>> _pickImage(
      PickImage event, Emitter<SlotState> emit) async {
    XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);

    if (file != null) {
      final formItems = state.formList.formItems;

      if (state.form.data![event.index].isMultiple!) {
        formItems[event.formIndex].images[event.index].add(ImageFile(
            name: state.form.data![event.index].inputFieldName!, file: file));
      } else {
        formItems[event.formIndex].images[event.index] = [
          ImageFile(
              name: state.form.data![event.index].inputFieldName!, file: file)
        ];
      }

      emit(state.copyWith(formList: FormViewList(formItems: formItems)));

      add(FormItemChanged(
          index: event.index, value: file.path, formIndex: event.formIndex));
    }
  }

  FutureOr<void> _getVisitDetails(
      GetVisitDetails event, Emitter<SlotState> emit) async {
    emit(state.copyWith(visitData: event.visitData));

    add(GetForm(formIndex: 0, visitData: event.visitData));
  }

  FutureOr<void> _getForm(GetForm event, Emitter<SlotState> emit) async {
    final form = await _apiRepo.post(
        endpoint: visitsSlotFormGetEndpoint,
        body: SlotModel(visitId: event.visitData.id!),
        responseModel: const SlotResponse());

    if (form != null && form.data!.isNotEmpty) {
      final focusList = <FocusNode>[];
      final controllerList = <TextEditingController>[];
      final valueList = <String>[];
      final dropDownList = <List<DropdownItem>>[];
      final images = <List<ImageFile>>[];
      final errorText = <String>[];

      for (int i = 0; i < form.data!.length; i++) {
        focusList.add(FocusNode());
        controllerList
            .add(TextEditingController(text: form.data![i].value ?? ''));
        valueList.add(form.data![i].value ?? '');
        dropDownList.add([]);
        images.add([]);
        errorText.add('');

        if (form.data![i].compareValue != null &&
            form.data![i].inputType == InputType.dropdown.name) {
          add(AddSource(
              compareValue: form.data![i].compareValue!,
              type: form.data![i].inputType!,
              index: i,
              formIndex: event.formIndex));
        }
      }

      final formItem = FormListItem(
          focusList: focusList,
          controllerList: controllerList,
          valueList: valueList,
          dropDownList: dropDownList,
          images: images,
          errorText: errorText);

      final List<FormListItem> formItemList =
          List.from(state.formList.formItems)
            ..clear()
            ..add(formItem);

      emit(state.copyWith(
          formName: 'Slot',
          dropDownSet: true,
          form: form,
          formList: FormViewList(formItems: formItemList)));
    }
  }

  FutureOr<void> _callFormula(CallFormula event, Emitter<SlotState> emit) {
    for (int i = 0; i < state.form.data!.length; i++) {
      bool existed = false;
      for (int j = 0; j < state.form.data![i].referenceValue!.length; j++) {
        if (state.form.data![i].referenceValue![j]!.value == event.fieldId) {
          existed = true;
        }
      }
      if (existed) {
        if (state.formList.formItems[event.formIndex]
                .valueList[event.fieldIndex] !=
            '') {
          add(SolveFormula(
              formData: state.form.data![i],
              index: i,
              fieldIndex: event.fieldIndex,
              formIndex: event.formIndex));
        } else {
          add(FormFieldChanged(
              index: i, value: '', formIndex: event.formIndex));
        }
      }
    }
  }

  FutureOr<void> _solveFormula(SolveFormula event, Emitter<SlotState> emit) {
    String formula = '';
    int count = 0;
    double? value;

    for (int i = 0; i < event.formData.referenceValue!.length; i++) {
      if (event.formData.referenceValue![i]!.type == FormulaType.id.name) {
        final value =
            getValue(event.formData.referenceValue![i]!, event.formIndex);
        if (value != '' && isNumeric(value)) {
          formula = formula +
              getValue(event.formData.referenceValue![i]!, event.formIndex);
          count++;
        }
      } else if (event.formData.referenceValue![i]?.type ==
              FormulaType.string.name ||
          event.formData.referenceValue![i]?.type == FormulaType.number.name) {
        formula = formula + event.formData.referenceValue![i]!.value!;
        count++;
      }
    }

    if (count == event.formData.referenceValue!.length) {
      value = formula.interpret() as double?;
    }
    if (event.formData.compareValue != null && value != null) {
      add(AddSourceObject(
          compareValue: event.formData.compareValue!,
          referenceValue: value,
          type: event.formData.inputType!,
          index: event.index,
          fieldIndex: event.fieldIndex,
          formIndex: event.formIndex));
    } else if (value != null) {
      add(FormFieldChanged(
          index: event.index,
          value: value.toString(),
          formIndex: event.formIndex));
    }
  }

  Future<FutureOr<void>> _addSource(
      AddSource event, Emitter<SlotState> emit) async {
    final sources = await _apiRepo.post(
        endpoint: sourceEndpoint,
        body: Source(
            compareValue: event.compareValue,
            referenceValue: event.referenceValue),
        responseModel: const SourceResponse());

    if (sources != null) {
      final items = <DropdownItem>[];
      for (int i = 0; i < sources.data!.length; i++) {
        items.add(DropdownItem(
            name: sources.data![i].value!, value: sources.data![i].id!));
      }

      final formItems = state.formList.formItems;

      formItems[event.formIndex].dropDownList[event.index] = items;

      emit(state.copyWith(formList: FormViewList(formItems: formItems)));
    }
  }

  Future<FutureOr<void>> _addSourceObject(
      AddSourceObject event, Emitter<SlotState> emit) async {
    final sources = await _apiRepo.post(
        endpoint: sourceEndpoint,
        body: Source(
            compareValue: event.compareValue,
            referenceValue: event.referenceValue),
        responseModel: const SourceObject());

    if (sources != null &&
        state.formList.formItems[event.formIndex].valueList[event.fieldIndex] !=
            '') {
      add(FormFieldChanged(
          index: event.index,
          value: sources.data!.value ?? '',
          formIndex: event.formIndex));
    } else {
      add(FormFieldChanged(
          index: event.index, value: '', formIndex: event.formIndex));
    }
  }

  String getValue(ReferenceValue referenceValue, int formIndex) {
    for (int i = 0; i < state.form.data!.length; i++) {
      if (referenceValue.value == state.form.data![i].id.toString()) {
        return state.formList.formItems[formIndex].valueList[i];
      }
    }
    return '';
  }

  Future<FutureOr<void>> _saveSlot(
      SaveSlot event, Emitter<SlotState> emit) async {
    if (!state.loading) {
      emit(state.copyWith(loading: true));
      bool validate = true;

      for (int formIndex = 0;
          formIndex < state.formList.formItems.length;
          formIndex++) {
        List<String> errorList = [];
        for (int i = 0;
            i < state.formList.formItems[formIndex].valueList.length;
            i++) {
          if (state.form.data![i].isRequired! &&
              state.formList.formItems[formIndex].valueList[i] == '') {
            errorList.add('Enter ${state.form.data![i].name!}');
          } else {
            errorList.add('');
          }
        }

        for (int i = 0; i < state.form.data!.length; i++) {
          if (state.form.data![i].isRequired! &&
              !Validator.isValidated(items: [
                FormItem(
                    text: state.formList.formItems[formIndex].valueList[i],
                    focusNode: state.formList.formItems[formIndex].focusList[i])
              ], navigator: _flutterNavigator)) {
            validate = false;
            break;
          }
        }

        if (!validate) {
          final formItems = state.formList.formItems;

          formItems[formIndex].errorText.clear();

          List.from(formItems[formIndex].errorText..addAll(errorList));

          emit(state.copyWith(
              formList: FormViewList(formItems: formItems),
              forms: Forms.invalid));
        }
      }

      if (validate) {
        Map<String, String> map = {};
        List<ImageFile> images = [];

        map['visit_id'] = state.visitData.id.toString();
        if (state.visitData.slot != null) {
          map['id'] = state.visitData.slot!.id!.toString();
        }

        for (int i = 0; i < state.form.data!.length; i++) {
          if (state.form.data![i].inputType == InputType.image.name) {
            images.addAll(state.formList.formItems[0].images[i]);
          } else {
            map[state.form.data![i].inputFieldName!] =
                state.formList.formItems[0].valueList[i];
          }
        }

        final saveForm = await _apiRepo.multipart(
            endpoint: state.visitData.slot != null
                ? visitsSlotEditEndpoint
                : visitsSlotSaveEndpoint,
            body: map,
            responseModel: const DefaultResponse(),
            files: images);

        if (saveForm != null) {
          ShowSnackBar(
              message: saveForm.message!, navigator: _flutterNavigator);
          _flutterNavigator.pop();
        }
      }
      emit(state.copyWith(loading: false));
    }
  }
}
