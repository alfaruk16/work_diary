import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/slot/widgets/form_item.dart';
import 'package:work_diary/features/app/presentation/activities/slot/bloc/bloc.dart';

class SlotScreen extends StatelessWidget {
  const SlotScreen({Key? key, required this.visitDetails}) : super(key: key);

  final VisitData visitDetails;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => SlotScreen(
          visitDetails: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SlotBloc(
          getIt<IFlutterNavigator>(), getIt<ImagePicker>(), getIt<ApiRepo>())
        ..add(GetVisitDetails(formIndex: 0, visitData: visitDetails)),
      child: FormView(
        visit: visitDetails,
      ),
    );
  }
}

class FormView extends StatelessWidget {
  const FormView({Key? key, required this.visit}) : super(key: key);
  final VisitData visit;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SlotBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<SlotBloc, SlotState>(builder: (context, state) {
      return CommonBodyB(
        sidePadding: 0,
        appBarTitle:
            '${state.visitData.slot != null ? 'Update' : 'Add'} ${state.formName}',
        bottomSection: state.form.data != null
            ? Column(
                children: [
                  ButtonB(
                    press: () {
                      bloc.add(SaveSlot());
                    },
                    text: state.visitData.slot != null ? 'Update' : 'Save',
                    textColor: bWhite,
                    bgColor: bSkyBlue,
                    shadow: true,
                    loading: state.loading,
                  ),
                ],
              )
            : null,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TextB(
                            text: "Visit Checking ",
                            textStyle: bBody3,
                          ),
                          Container(
                            height: 24,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: bWhiteGray,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: TextB(
                                text: '${visit.startedAt}',
                                textStyle: bBody3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextB(
                        text: '${visit.name}',
                        textStyle: bAccountField,
                        fontHeight: 1.3,
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          text: 'Shop Name: ',
                          style: const TextStyle(
                            color: bDark,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: '${visit.unitName} (${visit.unitCode})',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_sharp,
                            color: bLightBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          const TextB(
                            text: "Route: ",
                            fontWeight: FontWeight.w500,
                          ),
                          TextB(text: "${visit.unitAddress}"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: const Color(0XFFC9F2D4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.view_carousel,
                              color: Color(0XFF39BF5D),
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextB(
                                text: state.formName,
                                textStyle: bHeadline5,
                                fontColor: bBlack,
                                fontHeight: 1,
                              ),
                              TextB(
                                text: "Please Add ${state.formName}",
                                textStyle: bBody3,
                                fontHeight: 1.2,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      state.form.data != null
                          ? Container(
                              width: size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0XFFF0F4F9),
                                border:
                                    Border.all(color: const Color(0XFFD7D7D8)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: state.formList.formItems.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, formIndex) {
                                    List<int> groupIdArray = [];
                                    return state.form.data!.isNotEmpty
                                        ? ListView.builder(
                                            padding: const EdgeInsets.all(0),
                                            itemCount: state.form.data!.length,
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              String groupName = '';
                                              if (state.form.data![index]
                                                          .fieldGroupId !=
                                                      null &&
                                                  !groupIdArray.contains(state
                                                      .form
                                                      .data![index]
                                                      .fieldGroupId)) {
                                                groupIdArray.add(state
                                                    .form
                                                    .data![index]
                                                    .fieldGroupId!);
                                                groupName = state.form
                                                    .data![index].groupName!;
                                              } else {
                                                groupName = '';
                                              }
                                              return FormItem(
                                                formData:
                                                    state.form.data![index],
                                                index: index,
                                                formIndex: formIndex,
                                                groupName: groupName,
                                              );
                                            })
                                        : const TextB(
                                            text: 'No Form Field Created');
                                  }),
                            )
                          : const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
