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
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/children.dart';
import 'package:work_diary/features/app/data/models/form.dart';
import 'package:work_diary/features/app/data/models/source.dart';
import 'package:work_diary/features/app/domain/entities/children_response.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/default_response.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';
import 'package:work_diary/features/app/domain/entities/source_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/view/ongoing_visit_plan_screen.dart';
import 'package:function_tree/function_tree.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> {
  FormsBloc(this._flutterNavigator, this._imagePicker, this._apiRepo,
      this._localStorageRepo)
      : super(const FormsState()) {
    on<GoToOngoingVisitPlanScreen>(_goToOnGoingVisitPlan);
    on<FormItemChanged>(_formItemChanged);
    on<FormFieldChanged>(_formFieldChanged);
    on<DateChanged>(_dateChanged);
    on<GetVisitDetails>(_getVisitDetails);
    on<GetForm>(_getForm);
    on<AddSource>(_addSource);
    //on<AddSourceObject>(_addSourceObject);
    on<CallFormula>(_callFormula);
    //on<SolveFormula>(_solveFormula);
    on<SaveOrForm>(_saveOrForm);
    on<PickImage>(_pickImage);
    on<UpdateFormView>(_updateFormView);
    on<GetChildren>(_getChildren);
    on<RemoveChildren>(_removeChildren);
    on<CancelAnImage>(_cancelAnImage);
    on<RequestFocus>(_requestFocus);
  }

  final IFlutterNavigator _flutterNavigator;
  final ImagePicker _imagePicker;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _goToOnGoingVisitPlan(
      GoToOngoingVisitPlanScreen event, Emitter<FormsState> emit) {
    _flutterNavigator
        .push(OngoingVisitPlanScreen.route(visitData: state.visitData));
  }

  FutureOr<void> _formItemChanged(
      FormItemChanged event, Emitter<FormsState> emit) {
    emit(state.copyWith(
        valueList: List.from(state.valueList)
          ..removeAt(event.index)
          ..insert(event.index, event.value),
        prevIndex: event.index));
  }

  FutureOr<void> _formFieldChanged(
      FormFieldChanged event, Emitter<FormsState> emit) async {
    final valueList = state.valueList;
    valueList[event.index] = event.value;
    final controllerList = state.controllerList;
    if (event.value.isNotEmpty) {
      controllerList[event.index].text = event.value;
    } else {
      controllerList[event.index].clear();
    }

    emit(state.copyWith(valueList: valueList, controllerList: controllerList));

    // if (event.currentIndex == state.prevIndex && event.value.isNotEmpty) {
    //   EasyDebounce.debounce('debounce', const Duration(milliseconds: 5000), () {
    //     add(CallFormula(
    //         fieldId: state.form.data![event.index]!.id!.toString(),
    //         fieldIndex: event.index,
    //         currentIndex: event.currentIndex));
    //   });
    // } else {
    add(CallFormula(
        fieldId: state.form.data![event.index]!.id!.toString(),
        fieldIndex: event.index,
        currentIndex: event.currentIndex));
    // }
  }

  FutureOr<void> _dateChanged(DateChanged event, Emitter<FormsState> emit) {
    final date = DateFormat('yyyy-MM-dd').format(event.date);

    final controller = state.controllerList[event.index];
    controller.text = date;

    emit(state.copyWith(
        valueList: List.from(state.valueList
          ..removeAt(event.index)
          ..insert(event.index, date)),
        controllerList: List.from(state.controllerList
          ..removeAt(event.index)
          ..insert(event.index, controller))));
  }

  Future<FutureOr<void>> _pickImage(
      PickImage event, Emitter<FormsState> emit) async {
    XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);

    if (file != null) {
      final List<ImageFile> images = [];

      if (state.form.data![event.index]!.isMultiple!) {
        images
          ..addAll(state.images[event.index])
          ..add(ImageFile(
              name: state.form.data![event.index]!.inputFieldName!,
              file: file));
      } else {
        images.add(ImageFile(
            name: state.form.data![event.index]!.inputFieldName!, file: file));
      }

      emit(state.copyWith(
          images: List.from(state.images)
            ..removeAt(event.index)
            ..insert(event.index, images)));

      add(FormItemChanged(index: event.index, value: file.path));
    }
  }

  FutureOr<void> _getVisitDetails(
      GetVisitDetails event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        visitData: event.visitData, visitFormId: event.visitFormId ?? -1));

    add(GetForm(visitId: event.visitId, formId: event.formId));
  }

  FutureOr<void> _getForm(GetForm event, Emitter<FormsState> emit) async {
    final databaseKey = formDB + event.formId.toString();

    final data = await _localStorageRepo.readModel(
        key: databaseKey, model: const FormsResponse());
    if (data != null) {
      add(UpdateFormView(formsResponse: data, updateSource: false));
    }

    emit(state.copyWith(formLoading: true));

    final form = await _apiRepo.post(
        endpoint: getFormEndpoint,
        body: FormModel(
            visitId: event.visitId,
            formId: event.formId,
            visitFormId: state.visitFormId != -1 ? state.visitFormId : null),
        responseModel: const FormsResponse());

    emit(state.copyWith(formLoading: false));

    if (form != null) {
      _localStorageRepo.writeModel(key: databaseKey, value: form);
      if (!isClosed) {
        add(UpdateFormView(formsResponse: form, updateSource: true));
      }
    }
  }

  FutureOr<void> _updateFormView(
      UpdateFormView event, Emitter<FormsState> emit) {
    if (event.formsResponse.data!.isNotEmpty) {
      final focusList = <FocusNode>[];
      final controllerList = <TextEditingController>[];
      final valueList = <String>[];
      final dropDownList = <List<DropdownItem>>[];
      final images = <List<ImageFile>>[];
      final prevImages = <String>[];
      final errorText = <String>[];
      final loadingList = <bool>[];

      for (int i = 0; i < event.formsResponse.data!.length; i++) {
        final data = state.visitFormId != -1
            ? event.formsResponse.data![i]!.value ?? ''
            : '';
        focusList.add(FocusNode());
        controllerList.add(TextEditingController(text: data));
        valueList.add(data);
        dropDownList.add([]);
        images.add([]);
        prevImages.add(data);
        errorText.add('');
        loadingList.add(false);

        emit(state.copyWith(
            formName: event.formsResponse.formList!.name!,
            dropDownSet: true,
            form: event.formsResponse,
            focusList: focusList,
            controllerList: controllerList,
            valueList: valueList,
            dropDownList: dropDownList,
            images: images,
            prevImages: prevImages,
            errorText: errorText,
            loadingList: loadingList));

        if (event.updateSource) {
          if (event.formsResponse.data![i]?.compareValue != null &&
              event.formsResponse.data![i]?.inputType ==
                  InputType.dropdown.name) {
            add(AddSource(
                compareValue: event.formsResponse.data![i]!.compareValue!,
                type: event.formsResponse.data![i]!.inputType!,
                index: i));
          }
          if (state.visitFormId != -1) {
            add(CallFormula(
                fieldId: state.form.data![i]!.id!.toString(),
                fieldIndex: i,
                currentIndex: i));
          }
        }
      }
    }
  }

  Future<FutureOr<void>> _callFormula(
      CallFormula event, Emitter<FormsState> emit) async {
    for (int i = 0; i < state.form.data!.length; i++) {
      bool existed = false;
      for (int j = 0; j < state.form.data![i]!.referenceValue!.length; j++) {
        if (state.form.data![i]!.referenceValue![j]!.value == event.fieldId) {
          existed = true;
        }
      }
      if (existed) {
        if (state.valueList[event.fieldIndex] != '') {
          // add(SolveFormula(
          //     formData: state.form.data![i]!,
          //     index: i,
          //     fieldIndex: event.fieldIndex,
          //     currentIndex: event.currentIndex));

          String formula = '';
          int count = 0;
          double? value;
          final formData = state.form.data![i]!;

          for (int k = 0; k < formData.referenceValue!.length; k++) {
            if (formData.referenceValue![k]!.type == FormulaType.id.name) {
              final value = getValue(formData.referenceValue![k]!);
              if (value != '' && isNumeric(value)) {
                formula = formula + getValue(formData.referenceValue![k]!);
                count++;
              }
            } else if (formData.referenceValue![k]?.type ==
                    FormulaType.string.name ||
                formData.referenceValue![k]?.type == FormulaType.number.name) {
              formula = formula + formData.referenceValue![k]!.value!;
              count++;
            } else if (formData.referenceValue![k]?.type ==
                FormulaType.slot_field_id.name) {
              formula = formula +
                  getSlotValue(state.visitData.slot,
                      formData.referenceValue![k]!.value!);
              count++;
            }
          }

          if (count == formData.referenceValue!.length) {
            value = formula.interpret() as double?;
            if (formData.isCumulative!) {
              value = (value ?? 0) + (formData.previousValue ?? 0);
            }
          }
          if (formData.compareValue != null && value != null) {
            // add(AddSourceObject(
            //     compareValue: event.formData.compareValue!,
            //     referenceValue: value,
            //     type: event.formData.inputType!,
            //     index: event.index,
            //     fieldIndex: event.fieldIndex,
            //     currentIndex: event.currentIndex));

            add(FormFieldChanged(
                index: i,
                value: '',
                fieldIndex: event.fieldIndex,
                currentIndex: event.currentIndex));
            emit(state.copyWith(
                loadingList: List.from(state.loadingList)
                  ..removeAt(i)
                  ..insert(i, true)));
            final sources = await _apiRepo.post(
                endpoint: sourceEndpoint,
                body: Source(
                    compareValue: formData.compareValue!,
                    referenceValue: value),
                responseModel: const SourceObject());
            emit(state.copyWith(
                loadingList: List.from(state.loadingList)
                  ..removeAt(i)
                  ..insert(i, false)));

            if (sources != null && state.valueList[event.fieldIndex] != '') {
              add(FormFieldChanged(
                  index: i,
                  value: sources.data!.value ?? '',
                  fieldIndex: event.fieldIndex,
                  currentIndex: event.currentIndex));
            } else {
              add(RequestFocus(focusNode: state.focusList[event.fieldIndex]));
            }
          } else if (value != null) {
            add(FormFieldChanged(
                index: i,
                value: value.toStringAsFixed(3),
                fieldIndex: event.fieldIndex,
                currentIndex: event.currentIndex));
          }
        } else {
          add(FormFieldChanged(
              index: i,
              value: '',
              fieldIndex: event.fieldIndex,
              currentIndex: event.currentIndex));
        }
      }
    }
  }

  // Future<FutureOr<void>> _solveFormula(
  //     SolveFormula event, Emitter<FormsState> emit) async {
  //   String formula = '';
  //   int count = 0;
  //   double? value;
  //
  //   for (int i = 0; i < event.formData.referenceValue!.length; i++) {
  //     if (event.formData.referenceValue![i]!.type == FormulaType.id.name) {
  //       final value = getValue(event.formData.referenceValue![i]!);
  //       if (value != '' && isNumeric(value)) {
  //         formula = formula + getValue(event.formData.referenceValue![i]!);
  //         count++;
  //       }
  //     } else if (event.formData.referenceValue![i]?.type ==
  //             FormulaType.string.name ||
  //         event.formData.referenceValue![i]?.type == FormulaType.number.name) {
  //       formula = formula + event.formData.referenceValue![i]!.value!;
  //       count++;
  //     } else if (event.formData.referenceValue![i]?.type ==
  //         FormulaType.slot_field_id.name) {
  //       formula = formula +
  //           getSlotValue(state.visitData.slot,
  //               event.formData.referenceValue![i]!.value!);
  //       count++;
  //     }
  //   }
  //
  //   if (count == event.formData.referenceValue!.length) {
  //     value = formula.interpret() as double?;
  //     if (event.formData.isCumulative!) {
  //       value = (value ?? 0) + (event.formData.previousValue ?? 0);
  //     }
  //   }
  //   if (event.formData.compareValue != null && value != null) {
  //     // add(AddSourceObject(
  //     //     compareValue: event.formData.compareValue!,
  //     //     referenceValue: value,
  //     //     type: event.formData.inputType!,
  //     //     index: event.index,
  //     //     fieldIndex: event.fieldIndex,
  //     //     currentIndex: event.currentIndex));
  //     add(FormFieldChanged(
  //         index: event.index,
  //         value: '',
  //         fieldIndex: event.fieldIndex,
  //         currentIndex: event.currentIndex));
  //     emit(state.copyWith(
  //         loadingList: List.from(state.loadingList)
  //           ..removeAt(event.index)
  //           ..insert(event.index, true)));
  //     await Future.delayed(Duration(milliseconds: 5000));
  //     final sources = await _apiRepo.post(
  //         endpoint: sourceEndpoint,
  //         body: Source(
  //             compareValue: event.formData.compareValue!,
  //             referenceValue: value),
  //         responseModel: const SourceObject());
  //     emit(state.copyWith(
  //         loadingList: List.from(state.loadingList)
  //           ..removeAt(event.index)
  //           ..insert(event.index, false)));
  //
  //     if (sources != null && state.valueList[event.fieldIndex] != '') {
  //       add(FormFieldChanged(
  //           index: event.index,
  //           value: sources.data!.value ?? '',
  //           fieldIndex: event.fieldIndex,
  //           currentIndex: event.currentIndex));
  //     } else {
  //       add(RequestFocus(focusNode: state.focusList[event.fieldIndex]));
  //     }
  //   } else if (value != null) {
  //     add(FormFieldChanged(
  //         index: event.index,
  //         value: value.toStringAsFixed(3),
  //         fieldIndex: event.fieldIndex,
  //         currentIndex: event.currentIndex));
  //   }
  // }

  Future<FutureOr<void>> _addSource(
      AddSource event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        loadingList: List.from(state.loadingList)
          ..removeAt(event.index)
          ..insert(event.index, true)));
    final sources = await _apiRepo.post(
        endpoint: sourceEndpoint,
        body: Source(
            compareValue: event.compareValue,
            referenceValue: event.referenceValue),
        responseModel: const SourceResponse());
    emit(state.copyWith(
        loadingList: List.from(state.loadingList)
          ..removeAt(event.index)
          ..insert(event.index, false)));
    if (sources != null) {
      final items = <DropdownItem>[];
      for (int i = 0; i < sources.data!.length; i++) {
        items.add(DropdownItem(
            name: sources.data![i].value!, value: sources.data![i].id!));
      }
      emit(state.copyWith(
          dropDownList: List.from(state.dropDownList)
            ..removeAt(event.index)
            ..insert(event.index, items)));
    }
  }

  // Future<FutureOr<void>> _addSourceObject(
  //     AddSourceObject event, Emitter<FormsState> emit) async {
  //   add(FormFieldChanged(
  //       index: event.index,
  //       value: '',
  //       fieldIndex: event.fieldIndex,
  //       currentIndex: event.currentIndex));
  //   emit(state.copyWith(
  //       loadingList: List.from(state.loadingList)
  //         ..removeAt(event.index)
  //         ..insert(event.index, true)));
  //   final sources = await _apiRepo.post(
  //       endpoint: sourceEndpoint,
  //       body: Source(
  //           compareValue: event.compareValue,
  //           referenceValue: event.referenceValue),
  //       responseModel: const SourceObject());
  //   emit(state.copyWith(
  //       loadingList: List.from(state.loadingList)
  //         ..removeAt(event.index)
  //         ..insert(event.index, false)));
  //
  //   if (sources != null && state.valueList[event.fieldIndex] != '') {
  //     add(FormFieldChanged(
  //         index: event.index,
  //         value: sources.data!.value ?? '',
  //         fieldIndex: event.fieldIndex,
  //         currentIndex: event.currentIndex));
  //   } else {
  //     add(RequestFocus(focusNode: state.focusList[event.fieldIndex]));
  //   }
  // }

  String getValue(ReferenceValue referenceValue) {
    for (int i = 0; i < state.form.data!.length; i++) {
      if (referenceValue.value == state.form.data![i]!.id.toString()) {
        return state.valueList[i];
      }
    }
    return '';
  }

  Future<FutureOr<void>> _saveOrForm(
      SaveOrForm event, Emitter<FormsState> emit) async {
    if (!isLoading(state.loadingList)) {
      if (!state.loading) {
        emit(state.copyWith(loading: true));
        bool validate = true;

        List<String> errorList = [];
        for (int i = 0; i < state.valueList.length; i++) {
          if (state.form.data![i]!.isRequired! && state.valueList[i] == '') {
            errorList.add(
                '${state.form.data![i]!.inputType == InputType.image.name ? 'Add' : state.form.data![i]!.inputType == InputType.dropdown.name ? 'Select' : 'Enter'} ${state.form.data![i]!.name!}');
          } else {
            errorList.add('');
          }
        }

        for (int i = 0; i < state.form.data!.length; i++) {
          if (state.form.data![i]!.isRequired! &&
              !Validator.isValidated(items: [
                FormItem(
                    text: state.valueList[i], focusNode: state.focusList[i])
              ], navigator: _flutterNavigator)) {
            validate = false;
            break;
          }
        }

        if (!validate) {
          emit(state.copyWith(errorText: errorList, forms: Forms.invalid));
        }

        if (validate) {
          Map<String, String> map = {};
          List<ImageFile> images = [];

          map['form_id'] = state.form.formList!.id.toString();
          map['visit_id'] = state.form.formList!.visitId.toString();
          map['id'] =
              state.visitFormId != -1 ? state.visitFormId.toString() : "";

          for (int i = 0; i < state.form.data!.length; i++) {
            if (state.form.data![i]!.inputType == InputType.image.name) {
              images.addAll(state.images[i]);
            } else {
              map[state.form.data![i]!.inputFieldName!] = state.valueList[i];
            }
          }

          final saveForm = await _apiRepo.multipart(
              endpoint:
                  state.visitFormId != -1 ? editFormEndpoint : saveFormEndpoint,
              body: map,
              responseModel: const DefaultResponse(),
              files: images);

          if (saveForm != null) {
            ShowSnackBar(
                message: saveForm.message!, navigator: _flutterNavigator);
            if (!state.form.formList!.canAddMore!) {
              _flutterNavigator.pop();
            } else {
              add(GetVisitDetails(
                  visitId: state.form.formList!.visitId!,
                  formId: state.form.formList!.id!,
                  visitData: state.visitData));
              if (event.back) {
                _flutterNavigator.pop();
              }
            }
          }
        }
        emit(state.copyWith(loading: false));
      }
    } else {
      ShowSnackBar(
          message: "Please wait for previous network request",
          navigator: _flutterNavigator,
          color: Colors.black);
    }
  }

  Future<FutureOr<void>> _getChildren(
      GetChildren event, Emitter<FormsState> emit) async {
    final bool hasChild = hasChildren(state.form.data, event.id);
    if (state.valueList[event.fieldIndex] != event.name || !hasChild) {
      if (hasChild) {
        add(RemoveChildren(
            fieldIndex: event.fieldIndex, parenId: event.parenId));
      }

      if (event.childrenCount > 0) {
        emit(state.copyWith(
            loadingList: List.from(state.loadingList)
              ..removeAt(event.fieldIndex)
              ..insert(event.fieldIndex, true)));
        final children = await _apiRepo.post(
            endpoint: getFormChildrenEndpoint,
            body: Children(
                visitId: state.visitData.id!,
                formId: state.form.formList!.id!,
                parentId: event.id,
                parentValue: event.parentValue),
            responseModel: const ChildrenResponse());

        emit(state.copyWith(
            loadingList: List.from(state.loadingList)
              ..removeAt(event.fieldIndex)
              ..insert(event.fieldIndex, false)));

        if (children != null) {
          List<FocusNode> focusList = [];
          List<TextEditingController> controllerList = [];

          for (int i = 0; i < children.data!.length; i++) {
            focusList.add(FocusNode());
            controllerList.add(TextEditingController());
          }

          emit(state.copyWith(
              form: FormsResponse(
                  data: List.from((state.form.data
                    ?..insertAll(event.fieldIndex + 1,
                        children.data as Iterable<FormData?>)) as Iterable),
                  meta: state.form.meta,
                  formList: state.form.formList),
              focusList: List.from(
                  state.focusList..insertAll(event.fieldIndex + 1, focusList)),
              controllerList: List.from(state.controllerList
                ..insertAll(event.fieldIndex + 1, controllerList)),
              valueList: List.from(state.valueList
                ..insertAll(event.fieldIndex + 1, List.filled(children.data!.length, ''))),
              dropDownList: List.from(state.dropDownList..insertAll(event.fieldIndex + 1, List.filled(children.data!.length, []))),
              images: List.from(state.images..insertAll(event.fieldIndex + 1, List.filled(children.data!.length, []))),
              errorText: List.from(state.errorText..insertAll(event.fieldIndex + 1, List.filled(children.data!.length, ''))),
              loadingList: List.from(state.loadingList..insertAll(event.fieldIndex + 1, List.filled(children.data!.length, false)))));

          for (int i = 0; i < children.data!.length; i++) {
            if (children.data![i].inputType == InputType.dropdown.name) {
              add(AddSource(
                  type: children.data![i].inputType!,
                  compareValue: children.data![i].compareValue!,
                  index: event.fieldIndex + 1 + i));
            }
          }
        }
      }
    }
  }

  bool hasChildren(List<FormData?>? data, int? id) {
    for (int i = 0; i < data!.length; i++) {
      if (data[i]!.parentId == id) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> _removeChildren(
      RemoveChildren event, Emitter<FormsState> emit) {
    for (int i = event.fieldIndex + 1; i < state.form.data!.length; i++) {
      if (state.form.data![i]!.parentId != null &&
          state.form.data![i]!.parentId != event.parenId) {
        emit(state.copyWith(
          form: FormsResponse(
              data: List.from((state.form.data?..removeAt(i)) as Iterable),
              meta: state.form.meta,
              formList: state.form.formList),
          focusList: List.from(state.focusList..removeAt(i)),
          controllerList: List.from(state.controllerList..removeAt(i)),
          valueList: List.from(state.valueList..removeAt(i)),
          dropDownList: List.from(state.dropDownList..removeAt(i)),
          images: List.from(state.images..removeAt(i)),
          errorText: List.from(state.errorText..removeAt(i)),
          loadingList: List.from(state.loadingList..removeAt(i)),
        ));
        i--;
      } else {
        break;
      }
    }
  }

  FutureOr<void> _cancelAnImage(CancelAnImage event, Emitter<FormsState> emit) {
    final images = state.images[event.filedIndex];

    emit(state.copyWith(
        images: List.from(state.images)
          ..removeAt(event.filedIndex)
          ..insert(event.filedIndex,
              List.from(images)..removeAt(event.imageIndex))));
  }

  FutureOr<void> _requestFocus(RequestFocus event, Emitter<FormsState> emit) {
    FocusScope.of(_flutterNavigator.context).requestFocus(event.focusNode);
  }

  String getSlotValue(Slot? slot, String slotId) {
    if (slot != null) {
      for (int i = 0; i < slot.slotDetails!.length; i++) {
        if (slot.slotDetails![i].slotFieldId.toString() == slotId) {
          return slot.slotDetails![i].value.toString();
        }
      }
    }
    return '';
  }

  bool isLoading(List<bool> loadingList) {
    for (int i = 0; i < loadingList.length; i++) {
      if (loadingList[i]) {
        return true;
      }
    }
    return false;
  }
}
