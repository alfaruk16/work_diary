part of 'visitor_details_bloc.dart';

class VisitorDetailsState extends Equatable {
  const VisitorDetailsState({
    this.visitorDetails = const UserDetails(),
    this.chart = const ChartResponse(),
    this.pageLoader = false,
  });

  final UserDetails visitorDetails;
  final ChartResponse chart;
  final bool pageLoader;

  VisitorDetailsState copyWith({
    UserDetails? visitorDetails,
    ChartResponse? chart,
    bool? pageLoader,
  }) {
    return VisitorDetailsState(
      visitorDetails: visitorDetails ?? this.visitorDetails,
      chart: chart ?? this.chart,
      pageLoader: pageLoader ?? this.pageLoader,
    );
  }

  @override
  List<Object> get props => [visitorDetails, chart, pageLoader];
}

class VisitorDetailsInitial extends VisitorDetailsState {}
