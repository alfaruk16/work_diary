import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'widgets.dart';


class CircleBtn extends StatelessWidget {
  final VoidCallback? press;
  final IconData? icon;
  final String? title, subTitle;
  final Color? fontColor, iconColor;
  final double? btnSize;
  final Widget? child;
  final List<Color>? bgColor;

  const CircleBtn({
    Key? key,
    this.press,
    this.icon = Icons.star,
    this.title = "",
    this.subTitle = "",
    this.bgColor = const [bWhite, bWhite],
    this.btnSize = 60,
    this.fontColor = bWhite,
    this.iconColor = bDarkBlue,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            width: btnSize!, //Get.width * .3,
            height: btnSize!,
            padding: EdgeInsets.all((btnSize! * 8.50) / 100),
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0XFF0D3FE9), Color(0XFF1D68F5)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0XFF4F75ED),
                  offset: Offset(-(btnSize! * 4.67) / 100,
                      -(btnSize! * 5.33) / 100), //(x,y)
                  blurRadius: (btnSize! * 7.8) / 100,
                ),
                BoxShadow(
                  color: const Color(0xFF0B3FEE),
                  offset: Offset(
                      (btnSize! * 3.33) / 100, (btnSize! * 6.67) / 100), //(x,y)
                  blurRadius: (btnSize! * 5.4) / 100,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: bgColor!),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0XFF000000).withOpacity(0.25),
                    offset: const Offset(0, 4), //(x,y)
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: child != null
                    ? child!
                    : Icon(
                        icon,
                        size: (btnSize! * 55) / 100,
                        color: iconColor,
                      ),
              ),
            ),
          ),
          if (title != "")
            TextB(
              text: title!,
              textStyle: bHeadline5,
              fontColor: fontColor,
            ),
          if (subTitle != "")
            TextB(
              text: subTitle!,
              fontSize: 12,
              fontColor: fontColor,
            ),
        ],
      ),
    );
  }
}
