part of 'slot_bloc.dart';

abstract class SlotEvent extends Equatable {
  const SlotEvent();

  @override
  List<Object> get props => [];
}

class GetVisitDetails extends SlotEvent {
  const GetVisitDetails({required this.formIndex, required this.visitData});

  final int formIndex;
  final VisitData visitData;
}

class GetForm extends SlotEvent {
  const GetForm({required this.formIndex, required this.visitData});

  final int formIndex;
  final VisitData visitData;
}

class FormItemChanged extends SlotEvent {
  const FormItemChanged(
      {required this.index, required this.value, required this.formIndex});

  final int index;
  final String value;
  final int formIndex;
}

class FormFieldChanged extends SlotEvent {
  const FormFieldChanged(
      {required this.index, required this.value, required this.formIndex});

  final int index;
  final String value;
  final int formIndex;
}

class DateChanged extends SlotEvent {
  const DateChanged(
      {required this.index, required this.date, required this.formIndex});

  final int index;
  final DateTime date;
  final int formIndex;
}

class AddSource extends SlotEvent {
  const AddSource(
      {required this.type,
      required this.compareValue,
      this.referenceValue,
      required this.index,
      required this.formIndex});

  final String type;
  final num compareValue;
  final num? referenceValue;
  final int index;
  final int formIndex;
}

class AddSourceObject extends SlotEvent {
  const AddSourceObject(
      {required this.type,
      required this.compareValue,
      this.referenceValue,
      required this.index,
      required this.fieldIndex,
      required this.formIndex});

  final String type;
  final num compareValue;
  final num? referenceValue;
  final int index;
  final int fieldIndex;
  final int formIndex;
}

class CallFormula extends SlotEvent {
  const CallFormula(
      {required this.fieldId,
      required this.fieldIndex,
      required this.formIndex});

  final String fieldId;
  final int fieldIndex;
  final int formIndex;
}

class SolveFormula extends SlotEvent {
  const SolveFormula(
      {required this.index,
      required this.formData,
      required this.fieldIndex,
      required this.formIndex});

  final FormData formData;
  final int index;
  final int fieldIndex;
  final int formIndex;
}

class SaveSlot extends SlotEvent {}

class GoToOngoingVisitPlanScreen extends SlotEvent {}

class PickImage extends SlotEvent {
  const PickImage({required this.index, required this.formIndex});

  final int index;
  final int formIndex;
}

class GetSlot extends SlotEvent {
  const GetSlot({required this.visitId, required this.formIndex});
  final int formIndex;
  final int visitId;
}
