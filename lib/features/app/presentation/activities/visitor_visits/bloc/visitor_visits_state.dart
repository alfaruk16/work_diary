part of 'visitor_visits_bloc.dart';

class VisitorVisitsState extends Equatable {
  const VisitorVisitsState({
    this.isSupervisor = false,
    this.visitorDetails = const UserDetails(),
    this.isLoading = false,
    this.page = 1,
    this.isEndList = false,
    this.visits = const TodaysVisitResponse(),
  });

  final UserDetails visitorDetails;
  final bool isLoading, isEndList, isSupervisor;
  final int page;
  final TodaysVisitResponse visits;

  VisitorVisitsState copyWith({
    UserDetails? visitorDetails,
    bool? isLoading,
    bool? isEndList,
    bool? isSupervisor,
    int? page,
    TodaysVisitResponse? visits,
  }) {
    return VisitorVisitsState(
      isSupervisor: isSupervisor ?? this.isSupervisor,
      visitorDetails: visitorDetails ?? this.visitorDetails,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      isEndList: isEndList ?? this.isEndList,
      visits: visits ?? this.visits,
    );
  }

  @override
  List<Object> get props => [
        isSupervisor,
        visitorDetails,
        isLoading,
        page,
        isEndList,
        visits,
      ];
}

class VisitorVisitsInitial extends VisitorVisitsState {}
