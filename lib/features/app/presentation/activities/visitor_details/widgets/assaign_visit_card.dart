import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class AssignVisitCard extends StatelessWidget {
  const AssignVisitCard({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DottedBorder(
      options: RectDottedBorderOptions(
        color: bGreen,
        strokeWidth: 1.5,
        dashPattern: const [4, 3],
        padding: const EdgeInsets.all(1),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFFEEF4FF),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            press();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            width: size.width - 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TextB(
                      text: "Assign New Visit",
                      fontSize: 16,
                      fontColor: bBlack,
                    ),
                    SizedBox(height: 10),
                    TextB(
                      text: "You can create new visit in here",
                      fontColor: bGray,
                    ),
                  ],
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: bBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: bWhite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
