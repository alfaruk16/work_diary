import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/visit.dart';

Future previousToDoList(BuildContext context,
    {required Visits tododVisits,
    required Function press,
    required Function pressSwitch,
    required VoidCallback confirmStart,
    required bool loading}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      final dateController = [];

      for (int i = 0; i < tododVisits.data!.length; i++) {
        dateController.add(TextEditingController());
      }
      final dateFocusNode = FocusNode();
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3)),
                    image: DecorationImage(
                        image: ExactAssetImage(clockBgPng), fit: BoxFit.cover),
                  ),
                  child: const TextB(
                    text: "Previous to do list",
                    textStyle: bHeadline6,
                    fontColor: bWhite,
                    alignMent: TextAlign.center,
                    fontSize: 16,
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const TextB(
                              text:
                                  'Some of your previous visits aren\'t completed yet. You can extend/continue or close.'),
                          const SizedBox(height: 5),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10),
                          ...List.generate(tododVisits.data!.length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 0, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFE1E1E3)),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextB(
                                          text: tododVisits.data![index].name!,
                                          fontSize: 15,
                                          fontColor: bBlack,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              onGoingVisitSvg,
                                              width: 17,
                                              height: 15,
                                            ),
                                            const SizedBox(width: 8),
                                            TextB(
                                              text: tododVisits
                                                  .data![index].unitName!,
                                              fontSize: 13,
                                              fontColor: bDarkGray,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 135,
                                              child: TextFieldB(
                                                paddingWidth: 7,
                                                height: 27,
                                                bgColor:
                                                    const Color(0XFFF3F3F3),
                                                controller:
                                                    dateController[index],
                                                onTouch: () {
                                                  press(index,
                                                      dateController[index]);
                                                },
                                                suffixIcon: const Align(
                                                  widthFactor: 1,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 7),
                                                    child: Icon(
                                                      Icons.calendar_month,
                                                      size: 20,
                                                      color: bGray,
                                                    ),
                                                  ),
                                                ),
                                                isReadOnly: true,
                                                hintText:
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(DateTime.now()),
                                                focusNode: dateFocusNode,
                                                onChanged: (value) {},
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15),
                                                  child: TextB(
                                                    text: "Close/Continue",
                                                    fontColor: bGray,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SwitchView(
                                                  onChanged: (bool switchVal) {
                                                    pressSwitch(
                                                        switchVal, index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const TextB(
                                          text: 'Select date to continue',
                                          fontSize: 12,
                                          fontColor: bGray,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonB(
                          text: "Update",
                          press: () {
                            confirmStart();
                          },
                          heigh: 38,
                          fontSize: 16,
                          textColor: bWhite,
                          fontWeight: FontWeight.w400,
                          bgColor: bBlue,
                          loading: loading,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ));
    },
  );
}
