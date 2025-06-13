import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class DashboardMenuItem extends StatelessWidget {
  final IconData? leftIcon;
  final String? name;
  final VoidCallback? press;
  const DashboardMenuItem({
    Key? key,
    this.leftIcon,
    this.name = "",
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            Icon(
              leftIcon,
              color: bGray,
              size: 25,
            ),
            const SizedBox(width: 12),
            TextB(text: name!, fontColor: bBlack),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right,
              color: bGray,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}
