import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/color_darken.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class EmergencyVisitCart extends StatelessWidget {
  final String? subTitle, title, name, icon;
  final Color? bgColor, borderColor;
  final VoidCallback press;
  const EmergencyVisitCart({
    Key? key,
    this.subTitle = "Card Sub Title",
    this.title = "Card Title",
    this.name = "Place name",
    this.icon,
    this.bgColor = const Color(0XFFEEFBFF),
    this.borderColor = bLightBlueOne,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: InkWell(
            onTap: press,
            splashColor: darken(const Color(0XFFEEFBFF)),
            child: Ink(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(width: 1.5, color: borderColor!),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon!,
                    width: 24,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextB(
                            maxLines: 1,
                            text: subTitle!,
                            fontSize: 13,
                          ),
                          TextB(
                            maxLines: 1,
                            text: title!,
                            fontSize: 16,
                            fontColor: bBlack,
                          ),
                          TextB(
                            maxLines: 1,
                            text: name!,
                            fontSize: 12,
                            fontColor: bGray,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: bWhite,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0XFFD3D3D3)),
                    ),
                    child: const Icon(
                      Icons.east,
                      size: 16,
                      color: Color(0XFF8A91A8),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
