import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/widgets/text.dart';

import '../../../../../../core/utils/colors.dart';

class PerformanceButton extends StatelessWidget {
  const PerformanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions( color: bGreen,
          strokeWidth: 1.5,
          dashPattern: const [4, 3],
          padding: const EdgeInsets.all(1)),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0XFFF8FFFA),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextB(
                    text: 'My Performance Report',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.black),
                SizedBox(height: 5),
                TextB(text: 'You can check your all activity'),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: SizedBox(
                height: 15,
                width: 15,
                child: SvgPicture.asset(vectorSvg),
              ),
            )
          ],
        ),
      ),
    );
  }
}
