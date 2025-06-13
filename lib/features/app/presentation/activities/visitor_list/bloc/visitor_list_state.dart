part of 'visitor_list_bloc.dart';

class VisitorListState extends Equatable {
  const VisitorListState({
    this.visitors = const Visitors(),
    this.pageLoader = false,
  });

  final Visitors visitors;
  final bool pageLoader;

  VisitorListState copyWith({
    Visitors? visitors,
    bool? pageLoader,
  }) {
    return VisitorListState(
      visitors: visitors ?? this.visitors,
      pageLoader: pageLoader ?? this.pageLoader,
    );
  }

  @override
  List<Object> get props => [visitors, pageLoader];
}

class VisitorListInitial extends VisitorListState {}
