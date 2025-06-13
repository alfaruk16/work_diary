import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/features/app/data/data_sources/remote_constants.dart';
import 'package:work_diary/features/app/data/models/company_unit_id.dart';
import 'package:work_diary/features/app/domain/entities/unit_details.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';

part 'unit_details_event.dart';
part 'unit_details_state.dart';

class UnitDetailsBloc extends Bloc<UnitDetailsEvent, UnitDetailsState> {
  UnitDetailsBloc(this._apiRepo, this._iFlutterNavigator)
      : super(UnitDetailsInitial()) {
    on<GetCompanyUnitDetails>(_getCompanyUnitDetails);
    on<GoToDashboard>(_goToDashboard);
    on<GoToAddNewUnit>(_goToAddNewUnit);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _getCompanyUnitDetails(
      GetCompanyUnitDetails event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(unitDetail: UnitDetails(data: event.unitData)));

    final unitDetails = await _apiRepo.post(
      endpoint: unitsDetailsEndpoint,
      body: CompanyUnitId(companyUnitId: event.unitData.companyUnitId!),
      responseModel: const UnitDetails(),
    );

    if (unitDetails != null) {
      emit(state.copyWith(unitDetail: unitDetails));
    }
  }

  FutureOr<void> _goToDashboard(
      GoToDashboard event, Emitter<UnitDetailsState> emit) {
    _iFlutterNavigator.popUntil((route) => route.isFirst);
  }

  FutureOr<void> _goToAddNewUnit(
      GoToAddNewUnit event, Emitter<UnitDetailsState> emit) {
    _iFlutterNavigator.pop();
  }
}
