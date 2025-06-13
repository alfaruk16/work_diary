import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';

class CheckOutButton extends StatelessWidget {
  final VoidCallback press;
  const CheckOutButton({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: bDarkRed,
              elevation: 0,
              fixedSize: const Size.fromHeight(38),
            ),
            onPressed: press,
            icon: const Icon(
              Icons.logout,
              size: 20,
              color: bWhite,
            ),
            label: const TextB(
              text: "Check Out",
              textStyle: bHeadline6,
              fontColor: bWhite,
            ),
          ),
        ],
      ),
    );
  }
}
