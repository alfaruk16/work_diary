import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';

Future changeStatus(
  BuildContext context, {
  required Function getComment,
}) {
  final focusNode = FocusNode();
  final commentController = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextB(
              text: "Comments",
              alignMent: TextAlign.left,
              textStyle: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            TextFieldB(
              maxLines: 5,
              controller: commentController,
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
                    text: "Change",
                    fontSize: 16,
                    bgColor: bBlue,
                    textColor: bWhite,
                    shadow: false,
                    press: () {
                      getComment(commentController.text);
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
