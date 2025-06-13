import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/widgets/text.dart';

import '../utils/utils.dart';

class BigCamera extends StatelessWidget {
  const BigCamera(
      {Key? key,
      required this.press,
      this.tittle = '',
      this.errorText = '',
      this.labelSize = 16,
      this.padding = 5})
      : super(key: key);

  final VoidCallback press;
  final String tittle;
  final String errorText;
  final double labelSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tittle != '')
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextB(
              text: tittle,
              textStyle: TextStyle(fontSize: labelSize),
              fontColor: bDark,
            ),
          ),
        SizedBox(height: padding),
        GestureDetector(
          onTap: press,
          child: DottedBorder(
            options: RectDottedBorderOptions( color: bGreen,
              strokeWidth: 1.5,
              dashPattern: const [4, 3],
              padding: const EdgeInsets.all(1)),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0XFFEFFFF3),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: SvgPicture.asset(
                  cameraSvg,
                  width: 80,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        if (errorText != '')
          TextB(
            text: errorText,
            fontSize: 12,
            fontColor: bDarkRed,
          )
      ],
    );
  }
}
