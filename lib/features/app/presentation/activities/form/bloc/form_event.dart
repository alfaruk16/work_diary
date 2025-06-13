part of 'form_bloc.dart';

abstract class FormsEvent extends Equatable {
  const FormsEvent();

  @override
  List<Object> get props => [];
}

class GetVisitDetails extends FormsEvent {
  const GetVisitDetails(
      {required this.visitId,
      required this.formId,
      required this.visitData,
      this.visitFormId});

  final int visitId;
  final int formId;
  final VisitData visitData;
  final int? visitFormId;
}

class GetForm extends FormsEvent {
  const GetForm({required this.visitId, required this.formId});

  final int visitId;
  final int formId;
}

class FormItemChanged extends FormsEvent {
  const FormItemChanged({required this.index, required this.value});

  final int index;
  final String value;
}

class FormFieldChanged extends FormsEvent {
  const FormFieldChanged(
      {required this.index,
      required this.fieldIndex,
      required this.value,
      required this.currentIndex});

  final int index;
  final int fieldIndex;
  final String value;
  final int currentIndex;
}

class DateChanged extends FormsEvent {
  const DateChanged({required this.index, required this.date});

  final int index;
  final DateTime date;
}

class AddSource extends FormsEvent {
  const AddSource(
      {required this.type,
      required this.compareValue,
      this.referenceValue,
      required this.index});

  final String type;
  final num compareValue;
  final num? referenceValue;
  final int index;
}

class AddSourceObject extends FormsEvent {
  const AddSourceObject(
      {required this.type,
      required this.compareValue,
      this.referenceValue,
      required this.index,
      required this.fieldIndex,
      required this.currentIndex});

  final String type;
  final num compareValue;
  final num? referenceValue;
  final int index;
  final int fieldIndex;
  final int currentIndex;
}

class CallFormula extends FormsEvent {
  const CallFormula(
      {required this.fieldId,
      required this.fieldIndex,
      required this.currentIndex});

  final String fieldId;
  final int fieldIndex;
  final int currentIndex;
}

class SolveFormula extends FormsEvent {
  const SolveFormula(
      {required this.index,
      required this.formData,
      required this.fieldIndex,
      required this.currentIndex});

  final FormData formData;
  final int index;
  final int fieldIndex;
  final int currentIndex;
}

class SaveOrForm extends FormsEvent {
  const SaveOrForm({this.back = false});
  final bool back;
}

class GoToOngoingVisitPlanScreen extends FormsEvent {}

class PickImage extends FormsEvent {
  const PickImage({required this.index});

  final int index;
}

class GetSlot extends FormsEvent {
  const GetSlot({required this.visitId});
  final int visitId;
}

class UpdateFormView extends FormsEvent {
  const UpdateFormView(
      {required this.formsResponse, required this.updateSource});
  final FormsResponse formsResponse;
  final bool updateSource;
}

class GetChildren extends FormsEvent {
  const GetChildren(
      {required this.fieldIndex,
      required this.parentValue,
      required this.childrenCount,
      required this.parenId,
      required this.id,
      required this.name});
  final int fieldIndex;
  final int parentValue;
  final int childrenCount;
  final int? parenId;
  final int id;
  final String name;
}

class RemoveChildren extends FormsEvent {
  const RemoveChildren({required this.fieldIndex, this.parenId});
  final int fieldIndex;
  final int? parenId;
}

class CancelAnImage extends FormsEvent {
  const CancelAnImage({required this.filedIndex, required this.imageIndex});
  final int filedIndex;
  final int imageIndex;
}

class RequestFocus extends FormsEvent {
  const RequestFocus({required this.focusNode});
  final FocusNode focusNode;
}
