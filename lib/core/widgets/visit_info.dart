import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class VisitInfo extends StatelessWidget {
  const VisitInfo({
    this.title = '',
    this.info = '',
    this.iconName = '',
    this.infoFontSize = 14,
    this.infoColor = bBlack,
    this.infoFontWeight = FontWeight.w400,
    Key? key,
  }) : super(key: key);
  final String title, info;
  final String iconName;
  final double infoFontSize;
  final Color infoColor;
  final FontWeight infoFontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (iconName.isNotEmpty)
          SizedBox(
            child: SvgPicture.asset(iconName),
          ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != '')
                TextB(
                  text: title,
                  fontSize: 12,
                  fontColor: bDarkGray,
                ),
              if (title != '') const SizedBox(height: 5),
              TextB(
                text: info,
                fontSize: infoFontSize,
                fontColor: infoColor,
                fontWeight: infoFontWeight,
              ),
            ],
          ),
        )
      ],
    );
  }
}
