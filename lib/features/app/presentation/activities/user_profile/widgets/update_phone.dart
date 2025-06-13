import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';

Future showUpdatePhone(
  BuildContext context, {
  required String mobile,
  required Function getPhone,
}) {
  final focusNode = FocusNode();
  final phoneController = TextEditingController(text: mobile);

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextB(
              text: "Update Mobile",
              alignMent: TextAlign.left,
              textStyle: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            TextFieldB(
              controller: phoneController,
              focusNode: focusNode,
              onChanged: (val) {},
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 80,
                  child: ButtonB(
                    heigh: 40,
                    text: "Update",
                    fontSize: 16,
                    bgColor: bBlue,
                    textColor: bWhite,
                    shadow: false,
                    press: () {
                      getPhone(phoneController.text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
