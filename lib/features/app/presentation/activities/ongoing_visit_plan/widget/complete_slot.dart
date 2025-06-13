import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

Future completeSlotDialogue(
  BuildContext context, {
  required Slot slot,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextB(
                    text: 'Are you sure to complete?',
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 30),
                ButtonB(
                  text: "Complete Slot",
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
          ],
        ),
      );
    },
  );
}
