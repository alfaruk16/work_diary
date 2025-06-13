import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/add_unit/bloc/add_unit_bloc.dart';

class AddUnitScreen extends StatelessWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const AddUnitScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddUnitBloc(getIt<ApiRepo>(), getIt<IFlutterNavigator>(),
          getIt<LocalStorageRepo>()),
      child: AddUnitView(),
    );
  }
}

class AddUnitView extends StatelessWidget {
  AddUnitView({Key? key}) : super(key: key);

  final unitNameFocusNode = FocusNode();
  final ownerNameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddUnitBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<AddUnitBloc, AddUnitState>(builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "New Unit",
        menuList: [
          PopupMenuItem(
            child: const TextB(text: "Units"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.allUnit.name));
            },
          ),
          PopupMenuItem(
            child: const TextB(text: "Dashboard"),
            onTap: () {
              bloc.add(MenuItemScreens(name: PopUpMenu.dashboard.name));
            },
          )
        ],
        bottomSection: ButtonB(
          shadow: true,
          text: 'Save Unit',
          press: () {
            bloc.add(PressToContinue(
                unitNameFocusNode: unitNameFocusNode,
                ownerNameFocusNode: ownerNameFocusNode,
                phoneFocusNode: phoneFocusNode,
                addressFocusNode: addressFocusNode));
          },
          loading: state.loading,
        ),
        child: Material(
          color: bWhite,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 15),
              Container(
                  height: 42,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0XFFFFD249),
                      borderRadius: BorderRadius.circular(7),
                      image: const DecorationImage(
                          image: AssetImage(topMassageBg2Png))),
                  child: const TextB(
                    text: "Please add new unit info",
                    textStyle: bHeadline6,
                    fontColor: bBlack,
                    alignMent: TextAlign.center,
                    fontSize: 16,
                  )),
              const SizedBox(height: 15),
              const TextB(
                text: "Fill out the form below to add new unit",
                fontSize: 12,
                fontColor: bBlue,
              ),
              const SizedBox(height: 20),
              DropdownSearchB(
                label: "Zone",
                items: state.zoneList,
                loading: state.zoneLoading,
                selected: (int id) {
                  bloc.add(ZoneSelected(zoneId: id));
                },
                errorText:
                    state.forms == Forms.invalid && state.selectedZoneId == -1
                        ? 'Please select a Zone'
                        : '',
                isMandatory: true,
              ),
              const SizedBox(height: 20),
              DropdownSearchB(
                label: "Area",
                items: state.areaList,
                setState: state.resetArea,
                loading: state.areaLoading,
                selected: (int id) {
                  bloc.add(GetAreaId(areaId: id));
                },
              ),
              const SizedBox(height: 20),
              DropdownSearchB(
                  label: "Unit Type",
                  items: state.unitList,
                  loading: state.unitTypeLoading,
                  selected: (value) {
                    bloc.add(UnitTypeSelected(unitTypeId: value));
                  },
                  errorText: state.forms == Forms.invalid &&
                          state.selectedunitTypeId == -1
                      ? 'Please select a unit type'
                      : '',
                  isMandatory: true),
              if ((state.unitsConditionalField.canTagAsDealer != null &&
                      state.unitsConditionalField.canTagAsDealer!) ||
                  (state.unitsConditionalField.canTagAsSubDealer != null &&
                      state.unitsConditionalField.canTagAsSubDealer!))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    RadioGroupB(
                        reset: state.resetRadioGroup,
                        radioValues: [
                          RadioValue(name: "Retailer", value: 0),
                          if (state.unitsConditionalField.canTagAsSubDealer!)
                            RadioValue(name: 'Sub Dealer', value: 1),
                          if (state.unitsConditionalField.canTagAsDealer!)
                            RadioValue(name: 'Dealer', value: 2)
                        ],
                        index: (value) {
                          if (value == 2) {
                            bloc.add(const IsDealer(isDealer: true));
                            bloc.add(const IsSubDealer(isSubDealer: false));
                            bloc.add(const IsRetailer(isRetailer: false));
                            if (state.dealerCompanies.isEmpty) {
                              bloc.add(GetDealerCompanyName(
                                  unitTypeId: state.selectedunitTypeId));
                            }
                          } else if (value == 1) {
                            bloc.add(CheckZoneIsSelected());
                            bloc.add(const IsDealer(isDealer: false));
                            bloc.add(const IsSubDealer(isSubDealer: true));
                            bloc.add(const IsRetailer(isRetailer: false));
                          } else {
                            bloc.add(CheckZoneIsSelected());
                            bloc.add(const IsDealer(isDealer: false));
                            bloc.add(const IsSubDealer(isSubDealer: false));
                            bloc.add(const IsRetailer(isRetailer: true));
                          }
                        },
                        grid: 3)
                  ],
                ),
              if (state.unitsConditionalField.canSetUnitUnderDealer != null &&
                  !state.isDealerUnit &&
                  state.unitsConditionalField.canSetUnitUnderDealer!)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    DropdownSearchB(
                      label: "Dealer",
                      items: state.dealers,
                      loading: state.dealerLoading,
                      selected: (int id) {
                        bloc.add(GetDealerId(dealerId: id));
                      },
                      onTap: () {
                        bloc.add(CheckZoneIsSelected());
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.unitsConditionalField
                                  .canSetUnitUnderDealer! &&
                              state.selectedDealearId == -1
                          ? 'Please select a Dealer'
                          : '',
                      setState: state.resetDealer,
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              if (state.isDealerUnit &&
                  state.unitsConditionalField.canSetDealerCompanyName!)
                Column(
                  children: [
                    DropdownSearchB(
                      label: "Dealer Company Name",
                      setState: state.setCompany,
                      items: state.dealerCompanies,
                      loading: state.dealerCompanyLoading,
                      canTag: true,
                      selected: (objectives) {
                        bloc.add(GetDealerCompanyId(
                            dealerCompanyId: objectives.toString()));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.unitsConditionalField
                                  .canSetDealerCompanyName! &&
                              state.selectedDealearCompanyId == ''
                          ? 'Please select a Dealer Company Name'
                          : '',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              TextFieldB(
                fieldTitle: "Unit Name",
                hintText: "Example (John & Son's)",
                isMandatory: true,
                onChanged: (value) {
                  bloc.add(ChangeUnitName(unitName: value));
                },
                focusNode: unitNameFocusNode,
                errorText:
                    state.forms == Forms.invalid && state.unitName.isEmpty
                        ? 'Type Unit Name'
                        : '',
              ),
              const SizedBox(height: 20),
              TextFieldB(
                fieldTitle: "Owner Name",
                hintText: "Example (Mominul Islam)",
                isMandatory: true,
                onChanged: (value) {
                  bloc.add(ChangeOwnerName(ownerName: value));
                },
                focusNode: ownerNameFocusNode,
                errorText:
                    state.forms == Forms.invalid && state.ownerName.isEmpty
                        ? 'Please enter owner name'
                        : '',
              ),
              const SizedBox(height: 20),
              TextFieldB(
                fieldTitle: "Mobile",
                hintText: "Example (01231456789)",
                isMandatory: true,
                textInputType: TextInputType.number,
                onChanged: (value) {
                  bloc.add(ChangePhone(mobile: value));
                },
                focusNode: phoneFocusNode,
                errorText: state.forms == Forms.invalid && state.mobile.isEmpty
                    ? 'Please enter mobile'
                    : '',
              ),
              const SizedBox(height: 20),
              DropdownSearchB(
                label: "District",
                items: state.districtList,
                loading: state.districtLoading,
                selected: (int id) {
                  bloc.add(DistrictSelected(districtId: id));
                },
                errorText: state.forms == Forms.invalid &&
                        state.selectedDistrictId == -1
                    ? 'Please select a district'
                    : '',
                isMandatory: true,
              ),
              const SizedBox(height: 20),
              DropdownSearchB(
                label: "Upazila",
                items: state.upazilas,
                setState: state.setupazilas,
                loading: state.subDistrictLoading,
                selected: (int id) {
                  bloc.add(GetUpazilaId(upazilaId: id));
                },
                errorText: state.forms == Forms.invalid &&
                        state.selectedUpazilaId == -1
                    ? 'Please select a upazila'
                    : '',
                isMandatory: true,
              ),
              const SizedBox(height: 20),
              TextFieldB(
                fieldTitle: "Address",
                hintText: "Type address",
                isMandatory: true,
                maxLines: 5,
                onChanged: (value) {
                  bloc.add(ChangeAddress(address: value));
                },
                focusNode: addressFocusNode,
                errorText: state.forms == Forms.invalid && state.address.isEmpty
                    ? 'Please type address'
                    : '',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
