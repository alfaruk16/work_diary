import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class OrderInfo extends StatelessWidget {
  final String? leftText, rightText;
  final Color? color;
  final IconData? icon;
  final bool? isIcon;
  const OrderInfo({
    Key? key,
    this.leftText = "",
    this.rightText = "",
    this.color = bDarkGray,
    this.icon,
    this.isIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isIcon!)
                const Icon(
                  Icons.pin_drop_sharp,
                  size: 20,
                  color: bLightBlue,
                ),
              TextB(
                text: leftText!,
                fontColor: color,
              ),
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: TextB(
                text: rightText!,
                fontColor: color,
                alignMent: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
