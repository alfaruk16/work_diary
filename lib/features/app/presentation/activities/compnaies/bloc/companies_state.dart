part of 'companies_bloc.dart';

class CompaniesState extends Equatable {
  const CompaniesState(
      {this.companies = const Companies(), this.radios = const []});

  final Companies companies;
  final List<RadioValue> radios;

  CompaniesState copyWith({
    Companies? companies,
    List<RadioValue>? radios,
  }) {
    return CompaniesState(
        companies: companies ?? this.companies, radios: radios ?? this.radios);
  }

  @override
  List<Object?> get props => [companies, radios];
}
