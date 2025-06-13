part of 'check_in_form_bloc.dart';

class CheckInFormState extends Equatable {
  const CheckInFormState(
      {this.images = const [],
      this.visitData = const VisitData(),
      this.loading = false,
      this.forms = Forms.initial});

  final List<ImageFile> images;
  final VisitData visitData;
  final bool loading;
  final Forms forms;

  CheckInFormState copyWith(
      {List<ImageFile>? images,
      VisitData? visitData,
      bool? loading,
      Forms? forms}) {
    return CheckInFormState(
        images: images ?? this.images,
        visitData: visitData ?? this.visitData,
        loading: loading ?? this.loading,
        forms: forms ?? this.forms);
  }

  @override
  List<Object> get props => [images, visitData, loading, forms];
}

class CheckInFormInitial extends CheckInFormState {}
