import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/form/bloc/form_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/form/widgets/form_item.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/widget/visit_form_item.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen(
      {Key? key,
      required this.formItem,
      required this.visitDetails,
      this.visitFormId})
      : super(key: key);

  final FormList formItem;
  final VisitData visitDetails;
  final int? visitFormId;

  static Route<dynamic> route(
          {required FormList formItem,
          required VisitData visitData,
          int? visitFormId}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => FormsScreen(
            formItem: formItem,
            visitDetails: visitData,
            visitFormId: visitFormId),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormsBloc(getIt<IFlutterNavigator>(), getIt<ImagePicker>(),
          getIt<ApiRepo>(), getIt<LocalStorageRepo>())
        ..add(GetVisitDetails(
            visitId: formItem.visitId!,
            formId: formItem.id!,
            visitData: visitDetails,
            visitFormId: visitFormId)),
      child: FormView(visit: visitDetails),
    );
  }
}

class FormView extends StatelessWidget {
  const FormView({Key? key, required this.visit}) : super(key: key);
  final VisitData visit;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormsBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<FormsBloc, FormsState>(builder: (context, state) {
      return CommonBodyB(
          sidePadding: 0,
          appBarTitle: 'Add ${state.formName}',
          loading: state.formLoading,
          menuList: [
            PopupMenuItem(
              value: PopUpMenu.onGoingVisitPlan,
              child: const TextB(text: "Ongoing Visit Plan"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          bottomSection: state.form.formList != null
              ? Column(
                  children: [
                    ButtonB(
                      press: () {
                        bloc.add(const SaveOrForm(back: true));
                      },
                      text: state.visitFormId == -1 ? "Save" : "Update",
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TextB(
                          text: "Visit Started At ",
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
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Expanded(child: TextB(text: "${visit.unitAddress}")),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              state.form.data != null
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: bLightGray),
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                          if (state.visitFormId != -1)
                            const SizedBox(height: 20),
                          if (state.form.data != null &&
                              state.visitFormId == -1)
                            Column(
                              children: [
                                if (state.form.formList != null)
                                  visitFormItem(formItem: state.form.formList!),
                                const SizedBox(height: 20),
                              ],
                            ),
                          Container(
                              width: size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0XFFF0F4F9),
                                border:
                                    Border.all(color: const Color(0XFFD7D7D8)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: state.form.data!.isNotEmpty
                                  ? const FormItem()
                                  : const TextB(text: 'No Form Field Created')),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              state.form.formList != null &&
                                      state.form.formList!.canAddMore!
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: ButtonB(
                                        press: () {
                                          bloc.add(const SaveOrForm());
                                        },
                                        text: "+ Add More",
                                        textColor: bWhite,
                                        bgColor: bSkyBlue,
                                        shadow: true,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator()),
            ],
          ));
    });
  }
}
