import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/data/data_sources/local_keys.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/company_id.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/usecases/local_data.dart';
import 'package:work_diary/features/app/presentation/activities/add_unit/view/add_unit_screen.dart';
import 'package:work_diary/features/app/presentation/activities/unit_details/view/unit_details_screen.dart';

part 'unit_list_event.dart';
part 'unit_list_state.dart';

class UnitListBloc extends Bloc<UnitListEvent, UnitListState> {
  UnitListBloc(this._apiRepo, this._localStorageRepo, this._iFlutterNavigator)
      : super(AddUnitZoneInitial()) {
    on<GetUnit>(_getUnit);
    on<GoToUnitDetails>(_goToUnitDetails);
    on<GoToAddNewUnit>(_goToAddNewUnit);
    on<MenuItemScreens>(_menuItemScreens);
    on<PageIncrement>(_pageIncrement);

    add(GetUnit());
  }
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _getUnit(GetUnit event, Emitter<UnitListState> emit) async {
    final list = await _localStorageRepo.readModel(
        key: unitListDB, model: const UnitResponse());
    if (list != null) {
      emit(state.copyWith(units: list));
    }

    final unitResponse = await _apiRepo.post(
        endpoint: ownUnitEndpoint,
        body: CompanyId(
          companyId: await LocalData.getCompanyId(
                  localStorageRepo: _localStorageRepo) ??
              -1,
        ),
        responseModel: const UnitResponse());

    if (unitResponse != null) {
      emit(state.copyWith(units: unitResponse));
      _localStorageRepo.writeModel(key: unitListDB, value: unitResponse);
    }
  }

  FutureOr<void> _goToUnitDetails(
      GoToUnitDetails event, Emitter<UnitListState> emit) {
    _iFlutterNavigator.push(UnitDetailsScreen.route(unit: event.unitData));
  }

  FutureOr<void> _goToAddNewUnit(
      GoToAddNewUnit event, Emitter<UnitListState> emit) {
    _iFlutterNavigator.push(AddUnitScreen.route());
  }

  FutureOr<void> _menuItemScreens(
      MenuItemScreens event, Emitter<UnitListState> emit) {
    if (event.name == PopUpMenu.dashboard.name) {
      _iFlutterNavigator.pop();
    }
  }

  Future<FutureOr<void>> _pageIncrement(
      PageIncrement event, Emitter<UnitListState> emit) async {
    if (!state.incrementLoader &&
        state.currentPage < state.units.meta!.lastPage!) {
      emit(state.copyWith(incrementLoader: true));

      final unitResponse = await _apiRepo.post(
          endpoint: "$ownUnitEndpoint?page=${state.currentPage + 1}",
          body: CompanyId(
              companyId: await LocalData.getCompanyId(
                      localStorageRepo: _localStorageRepo) ??
                  -1),
          responseModel: const UnitResponse());

      if (unitResponse != null) {
        emit(state.copyWith(
            incrementLoader: false,
            currentPage: state.currentPage + 1,
            units: UnitResponse(
                meta: state.units.meta,
                data: state.units.data
                  ?..addAll(unitResponse.data as Iterable<UnitData>))));
      }
    }
  }
}
