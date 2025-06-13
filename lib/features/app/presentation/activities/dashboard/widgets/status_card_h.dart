import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/widgets.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    this.borderColor = const Color(0xFFD3D3D3),
    this.bgColor = bWhite,
    this.leftIcon,
    this.rightIcon,
    this.leftIconBgColor = const Color(0XFFD4FADE),
    this.leftIconColor,
    this.textColor = Colors.black87,
    this.press,
    this.title = '',
    this.total,
    this.completed,
  });

  final Color? textColor, borderColor, bgColor, leftIconBgColor, leftIconColor;
  final String? leftIcon, rightIcon;
  final String? title;
  final int? total, completed;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: (size.width - 50) / 3,
      width: (size.width - 50) / 2,
      child: InkWell(
        onTap: press,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: title == "Total Visit  Plan"
                    ? leftIconBgColor!.withOpacity(.45)
                    : leftIconBgColor!.withOpacity(.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: leftIconBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          leftIcon!,
                          height: 24,
                          width: 24,
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextB(
                text: title!,
                fontColor: textColor,
                fontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: Row(
                  children: [
                    TextB(
                      text: "$total Total",
                      fontColor: bDarkGray,
                      fontSize: 12,
                    ),
                    const SizedBox(width: 10),
                    if (completed != null)
                      TextB(
                        text: "$completed Completed",
                        fontColor: bDarkGray,
                        fontSize: 12,
                      ),
                    if (completed == null)
                      const TextB(
                        text: "Or Create New",
                        fontColor: bDarkGray,
                        fontSize: 12,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
