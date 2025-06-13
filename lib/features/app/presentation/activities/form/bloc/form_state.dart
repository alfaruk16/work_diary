part of 'form_bloc.dart';

class FormsState extends Equatable {
  const FormsState(
      {this.form = const FormsResponse(),
      this.focusList = const [],
      this.controllerList = const [],
      this.dropDownList = const [],
      this.images = const [],
      this.prevImages = const [],
      this.valueList = const [],
      this.errorText = const [],
      this.loadingList = const [],
      this.forms = Forms.initial,
      this.dropDownSet = false,
      this.prevIndex = 0,
      this.loading = false,
      this.formLoading = false,
      this.formName = '',
      this.visitData = const VisitData(),
      this.visitFormId = -1});

  final FormsResponse form;
  final List<FocusNode> focusList;
  final List<TextEditingController> controllerList;
  final List<List<DropdownItem>> dropDownList;
  final List<List<ImageFile>> images;
  final List<String> prevImages;
  final List<String> valueList;
  final List<String> errorText;
  final List<bool> loadingList;
  final Forms forms;
  final bool dropDownSet;
  final int prevIndex;
  final bool loading;
  final bool formLoading;
  final String formName;
  final VisitData visitData;
  final int visitFormId;

  FormsState copyWith(
      {FormsResponse? form,
      List<FocusNode>? focusList,
      List<TextEditingController>? controllerList,
      List<List<DropdownItem>>? dropDownList,
      List<List<ImageFile>>? images,
      List<String>? prevImages,
      List<String>? valueList,
      List<String>? errorText,
      Forms? forms,
      bool? dropDownSet,
      int? prevIndex,
      bool? loading,
      bool? formLoading,
      String? formName,
      VisitData? visitData,
      List<bool>? loadingList,
      int? visitFormId}) {
    return FormsState(
        form: form ?? this.form,
        focusList: focusList ?? this.focusList,
        controllerList: controllerList ?? this.controllerList,
        dropDownList: dropDownList ?? this.dropDownList,
        images: images ?? this.images,
        prevImages: prevImages ?? this.prevImages,
        valueList: valueList ?? this.valueList,
        errorText: errorText ?? this.errorText,
        forms: forms ?? this.forms,
        dropDownSet: dropDownSet ?? false,
        prevIndex: prevIndex ?? this.prevIndex,
        loading: loading ?? this.loading,
        formLoading: formLoading ?? this.formLoading,
        formName: formName ?? this.formName,
        visitData: visitData ?? this.visitData,
        loadingList: loadingList ?? this.loadingList,
        visitFormId: visitFormId ?? this.visitFormId);
  }

  @override
  List<Object> get props => [
        form,
        focusList,
        controllerList,
        dropDownList,
        images,
        prevImages,
        valueList,
        errorText,
        loadingList,
        forms,
        dropDownSet,
        prevIndex,
        loading,
        formLoading,
        formName,
        visitData,
        visitFormId
      ];
}
