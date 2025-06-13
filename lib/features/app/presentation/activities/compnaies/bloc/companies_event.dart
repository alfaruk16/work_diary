part of 'companies_bloc.dart';

abstract class CompaniesEvent extends Equatable {
  const CompaniesEvent();

  @override
  List<Object?> get props => [];
}

class GetCompanies extends CompaniesEvent {}

class CompanySelected extends CompaniesEvent {
  const CompanySelected({required this.index});
  final int index;
}

class GoToDashboard extends CompaniesEvent {}
