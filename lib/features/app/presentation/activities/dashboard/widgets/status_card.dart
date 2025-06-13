import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';

class DashboardStatusCard extends StatelessWidget {
  final Color? textColor,
      borderColor,
      bgColor,
      leftIconBgColor,
      leftIconColor,
      rightIconColor;
  final IconData? leftIcon, rightIcon;
  final String? leftIconSvg, rightIconSvg, title, subTitle;
  final VoidCallback? press;
  const DashboardStatusCard({
    Key? key,
    this.borderColor = const Color(0xFFD3D3D3),
    this.bgColor = bWhite,
    this.leftIconBgColor = const Color(0XFFD4FADE),
    this.leftIconColor,
    this.rightIconColor,
    this.leftIcon,
    this.rightIcon,
    this.leftIconSvg,
    this.rightIconSvg,
    this.textColor = bDark,
    this.press,
    this.title = "This is title",
    this.subTitle = "this is sub title",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor!),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
              color: const Color(0XFFA6A6A6).withOpacity(0.2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: leftIconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: leftIcon != null
                  ? Icon(
                      leftIcon!,
                      color: leftIconColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(7),
                      child: SvgPicture.asset(
                        leftIconSvg!,
                        colorFilter:
                            ColorFilter.mode(leftIconColor ?? Colors.transparent, BlendMode.srcIn),
                      ),
                    ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextB(
                    text: title!,
                    fontColor: textColor,
                    textStyle: bHeadline5,
                  ),
                  TextB(
                    text: subTitle!,
                    fontColor: textColor,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            rightIcon != null
                ? Icon(
                    rightIcon,
                    color: rightIconColor,
                  )
                : SvgPicture.asset(
                    rightIconSvg!,
                    colorFilter: ColorFilter.mode(
                        rightIconColor ?? Colors.transparent, BlendMode.srcIn),
                  ),
          ],
        ),
      ),
    );
  }
}
