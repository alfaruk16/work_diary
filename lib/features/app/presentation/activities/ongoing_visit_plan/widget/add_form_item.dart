import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/entities.dart';
import 'package:work_diary/features/app/presentation/activities/ongoing_visit_plan/widget/visit_form_item.dart';

class AddFormItem extends StatelessWidget {
  const AddFormItem(
      {Key? key,
      this.editable = true,
      this.formList,
      this.press,
      this.deleteForm,
      this.editForm,
      this.canComplete = false})
      : super(key: key);

  final bool editable;
  final List<FormList?>? formList;
  final Function? press;
  final Function? deleteForm;
  final Function? editForm;
  final bool canComplete;

  @override
  Widget build(BuildContext context) {
    return formList != null
        ? Column(
            children: [
              ...List.generate(
                formList!.length,
                (index) => formList![index]!.canAdd == false &&
                        formList![index]!.visitForms!.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          const Divider(
                            thickness: 1,
                            height: 0,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFEEF9FD),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.add_chart,
                                  color: bSkyBlue,
                                  size: 23,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextB(
                                    text: formList![index]!.name!,
                                    textStyle: bHeadline5,
                                    fontColor: bBlack,
                                    fontHeight: 1,
                                  ),
                                  TextB(
                                    text:
                                        "Please do ${formList![index]!.name!}",
                                    textStyle: bBody3,
                                    fontHeight: 1.2,
                                  ),
                                ],
                              )),
                              formList![index]!.canAddMore!
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 0),
                                      child: ActionButton(
                                        icon: Icons.add_circle,
                                        iconSize: 24,
                                        iconColor: getBtnColor(index),
                                        press: () {
                                          press!(index);
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 10),
                          visitFormItem(
                              formItem: formList![index]!,
                              deleteForm: deleteForm,
                              editForm: editForm,
                              editable: editable)
                        ],
                      )
                    : canComplete
                        ? Column(
                            children: [
                              const SizedBox(height: 10),
                              ButtonB(
                                text: formList![index]!.name,
                                bgColor: getBtnColor(index).withOpacity(0.15),
                                textColor: getBtnColor(index),
                                fontSize: 16,
                                shadow: false,
                                press: () {
                                  press!(index);
                                },
                              ),
                            ],
                          )
                        : const SizedBox(),
              )
            ],
          )
        : const TextB(text: "Loading...");
  }

  Color getBtnColor(int index) {
    final List<Color> colorList = [
      const Color(0XFF42B9E0),
      const Color(0XFF5076ED),
      const Color(0XFFE8B009),
      const Color(0XFF39BF5D),
    ];

    return colorList[index % colorList.length];
  }
}
