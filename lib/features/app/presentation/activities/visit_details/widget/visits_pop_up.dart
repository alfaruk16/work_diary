import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/started_visit_response.dart';

Future visitsPopUp(
  BuildContext context, {
  required StartedVisitList startedVisits,
  required Function confirmStart,
}) {
  // final focusNode = FocusNode();
  // final phoneController = TextEditingController(text: mobile);

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      return AlertDialog(
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
                    topLeft: Radius.circular(3), topRight: Radius.circular(3)),
                image: DecorationImage(
                    image: ExactAssetImage(clockBgPng), fit: BoxFit.cover),
              ),
              child: const TextB(
                text: "Start New Visit Plan",
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
                        TextB(
                            text: startedVisits.message ??
                                'Are you sure, you want to start this visit?'),
                        const SizedBox(height: 5),
                        if (startedVisits.data!.isNotEmpty)
                          const Divider(thickness: 1),
                        const SizedBox(height: 10),
                        ...List.generate(
                          startedVisits.data!.length,
                          (index) => Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0XFFF9F9FB),
                              border: Border.all(
                                  color: startedVisits.data![index].status ==
                                          ' On Going'
                                      ? bGreen.withOpacity(0.25)
                                      : const Color(0xFFE1E1E3)),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextB(
                                  text: startedVisits.data![index].name!,
                                  fontSize: 16,
                                ),
                                Row(
                                  children: [
                                    const TextB(
                                      text: 'Status:',
                                      fontSize: 14,
                                      fontColor: bGray,
                                    ),
                                    TextB(
                                      text: startedVisits.data![index].status!,
                                      fontSize: 14,
                                      fontColor:
                                          startedVisits.data![index].status ==
                                                  'On Going'
                                              ? bGreen
                                              : bDark,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width / 3.5,
                    child: ButtonB(
                      text: "Close",
                      press: () {
                        Navigator.of(context).pop();
                      },
                      heigh: 38,
                      fontSize: 16,
                      textColor: bBlack,
                      fontWeight: FontWeight.w400,
                      bgColor: bWhite,
                      borderColor: bBlack.withOpacity(.4),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ButtonB(
                      text: "Confirm",
                      press: () {
                        Navigator.of(context).pop();
                        confirmStart();
                      },
                      heigh: 38,
                      fontSize: 16,
                      textColor: bWhite,
                      fontWeight: FontWeight.w400,
                      bgColor: bBlue,
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
      );
    },
  );
}
