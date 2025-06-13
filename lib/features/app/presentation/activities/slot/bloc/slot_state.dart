part of 'slot_bloc.dart';

class SlotState extends Equatable {
  const SlotState(
      {this.form = const SlotResponse(),
      this.formList = const FormViewList(),
      this.forms = Forms.initial,
      this.dropDownSet = false,
      this.prevIndex = 0,
      this.loading = false,
      this.formName = '',
      this.visitData = const VisitData()});

  final SlotResponse form;
  final FormViewList formList;
  final Forms forms;
  final bool dropDownSet;
  final int prevIndex;
  final bool loading;
  final String formName;
  final VisitData visitData;

  SlotState copyWith(
      {SlotResponse? form,
      FormViewList? formList,
      Forms? forms,
      bool? dropDownSet,
      int? prevIndex,
      bool? loading,
      String? formName,
      VisitData? visitData}) {
    return SlotState(
        form: form ?? this.form,
        formList: formList ?? this.formList,
        forms: forms ?? this.forms,
        dropDownSet: dropDownSet ?? false,
        prevIndex: prevIndex ?? this.prevIndex,
        loading: loading ?? this.loading,
        formName: formName ?? this.formName,
        visitData: visitData ?? this.visitData);
  }

  @override
  List<Object> get props => [
        form,
        formList,
        forms,
        dropDownSet,
        prevIndex,
        loading,
        formName,
        visitData
      ];
}

class FormViewList {
  const FormViewList({this.formItems = const []});
  final List<FormListItem> formItems;
}

class FormListItem {
  const FormListItem(
      {this.focusList = const [],
      this.controllerList = const [],
      this.dropDownList = const [],
      this.images = const [],
      this.valueList = const [],
      this.errorText = const []});

  final List<FocusNode> focusList;
  final List<TextEditingController> controllerList;
  final List<List<DropdownItem>> dropDownList;
  final List<List<ImageFile>> images;
  final List<String> valueList;
  final List<String> errorText;
}
