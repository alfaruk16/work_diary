import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class Reason extends StatelessWidget {
  const Reason({Key? key, this.title = '', this.text = ''}) : super(key: key);
  final String title, text;

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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0XFFFFF5F8),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextB(text: title, fontColor: const Color(0XFFF2416C)),
            const SizedBox(height: 4),
            TextB(text: text, fontColor: bDark),
          ],
        ),
      ),
    );
  }
}
