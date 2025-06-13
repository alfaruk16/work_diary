import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/domain/entities/companies.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/view/dashboard_screen.dart';

part 'companies_event.dart';
part 'companies_state.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  CompaniesBloc(this._flutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(const CompaniesState()) {
    on<GetCompanies>(_getCompanies);
    on<CompanySelected>(_companySelected);
    on<GoToDashboard>(_goToDashboard);

    add(GetCompanies());
  }

  final IFlutterNavigator _flutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  Future<FutureOr<void>> _getCompanies(
      GetCompanies event, Emitter<CompaniesState> emit) async {
    final companies = await _localStorageRepo.readModel(
        key: companiesDB, model: getIt<Companies>());
    if (companies != null) {
      final radios = <RadioValue>[];
      for (int i = 0; i < companies.data!.length; i++) {
        radios.add(RadioValue(name: companies.data![i]!.name!, value: i));
      }
      emit(state.copyWith(companies: companies, radios: radios));
    }

    final companiesData = await _apiRepo.post(
        endpoint: companyEndpoint, responseModel: const Companies());

    if (companiesData != null) {
      final radios = <RadioValue>[];
      for (int i = 0; i < companiesData.data!.length; i++) {
        radios.add(RadioValue(name: companiesData.data![i]!.name!, value: i));
      }
      emit(state.copyWith(companies: companiesData, radios: radios));
      _localStorageRepo.writeModel(key: companiesDB, value: companiesData);
    }

    if (state.companies.data!.isNotEmpty) {
      _localStorageRepo.writeModel(
          key: companyDB, value: state.companies.data![0]);
    }
  }

  FutureOr<void> _companySelected(
      CompanySelected event, Emitter<CompaniesState> emit) {
    _localStorageRepo.writeModel(
        key: companyDB, value: state.companies.data![event.index]);
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<CompaniesState> emit) {
    _flutterNavigator.pushReplacement(DashBoardScreen.route());
  }
}
