import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class Reason extends StatelessWidget {
  const Reason({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions(
        color: bGreen,
        strokeWidth: 1.5,
        dashPattern: const [4, 3],
        padding: const EdgeInsets.all(1),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0XFFFFF5F8),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextB(text: "Postpone Reason", fontColor: Color(0XFFF2416C)),
            SizedBox(height: 4),
            TextB(
              text:
                  "This visit is not important for us in this time, you need to visit after 2 days later or a week",
              fontColor: bDark,
            ),
          ],
        ),
      ),
    );
  }
}
