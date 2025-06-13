import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/domain/entities/companies.dart';
import 'package:work_diary/features/app/domain/entities/user_profile.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';

class LocalData {
  static Future<int>? getCompanyId(
      {required LocalStorageRepo localStorageRepo}) async {
    final company = await localStorageRepo.readModel(
        key: companyDB, model: const Company());
    return company!.id!;
  }

  static Future<bool> hasAreaPlan(
      {required LocalStorageRepo localStorageRepo}) async {
    final company = await localStorageRepo.readModel(
        key: companyDB, model: const Company());
    return company!.areaPlan ?? false;
  }

  static Future<bool>? isSupervisor(
      {required LocalStorageRepo localStorageRepo}) async {
    final user = await localStorageRepo.readModel(
        key: userProfileDB, model: const UserDetails());
    return user!.data!.isSupervisor!;
  }

  static Future<int> getUserId(
      {required LocalStorageRepo localStorageRepo}) async {
    final user = await localStorageRepo.readModel(
        key: userProfileDB, model: const UserDetails());
    return user!.data!.id!;
  }

  static Future<String>? getCompanyUnitName(
      {required LocalStorageRepo localStorageRepo}) async {
    final companies = await localStorageRepo.readModel(
        key: companiesDB, model: const Companies());
    return companies!.message!;
  }

  static Future<bool> isCheckInEnabled(
      {required LocalStorageRepo localStorageRepo}) async {
    final company = await localStorageRepo.readModel(
        key: companyDB, model: const Company());
    return company != null ? company.checkingEnabled ?? false : false;
  }
}
