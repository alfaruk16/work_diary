import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/visit_confirmation_response.dart';

Future confirmModal(
  BuildContext context, {
  required int id,
  required VisitConfirmationResponse formList,
  required VoidCallback confirmBtn,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(15),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(completeConfirmPng),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: formList.formList != null
                  ? Column(
                      children: List.generate(
                        formList.formList!.length,
                        (index) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.only(right: 7),
                                  decoration: const BoxDecoration(
                                    color: bDark,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Flexible(
                                  child: TextB(
                                    text:
                                        "${formList.formList![index]!.name!}  ${formList.formList![index]!.isSkippable!} ?",
                                    fontSize: 14,
                                    fontColor: bDark,
                                    alignMent: TextAlign.center,
                                  ),
                                ),
                                const TextB(
                                  text: " Missing",
                                  fontSize: 14,
                                  fontColor: bGray,
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 10),
            TextB(
              text: formList.message!,
              fontSize: 14,
              fontHeight: 1.35,
              fontColor: bDarkGray,
              alignMent: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: formList.confirmBtn!
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                ButtonB(
                  text: "Keep editing",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  heigh: 38,
                  fontSize: 18,
                  textColor: bDark,
                  fontWeight: FontWeight.w400,
                  shadow: false,
                  bgColor: bWhite,
                  borderColor: bExtraLightGray,
                ),
                const SizedBox(width: 8),
                if (formList.confirmBtn!)
                  ButtonB(
                    text: "Complete Visit",
                    press: () {
                      confirmBtn();
                      Navigator.pop(context);
                    },
                    heigh: 38,
                    fontSize: 18,
                    textColor: bWhite,
                    fontWeight: FontWeight.w400,
                    bgColor: bGreen,
                  ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
    },
  );
}
