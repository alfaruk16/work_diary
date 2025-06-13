import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';

Future formDeleteConfirmation(
  BuildContext context, {
  required Function getYes,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextB(
              text: "Are you sure, You want to delete this?",
              alignMent: TextAlign.left,
              textStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonB(
                  text: "Close",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  heigh: 38,
                  fontSize: 16,
                  textColor: bWhite,
                  fontWeight: FontWeight.w400,
                  bgColor: bDarkRed.withOpacity(0.8),
                ),
                ButtonB(
                  heigh: 38,
                  text: "Yes",
                  fontSize: 16,
                  bgColor: bBlue,
                  textColor: bWhite,
                  shadow: false,
                  press: () {
                    getYes(true);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
