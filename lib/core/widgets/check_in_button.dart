import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';

class CheckInButton extends StatelessWidget {
  final VoidCallback press;
  const CheckInButton({
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
              backgroundColor: bYellow,
              elevation: 0,
              fixedSize: const Size.fromHeight(38),
            ),
            onPressed: press,
            icon: const Icon(
              Icons.login,
              size: 20,
              color: bBlack,
            ),
            label: const TextB(
              text: "Check In",
              textStyle: bHeadline6,
              fontColor: bBlack,
            ),
          ),
        ],
      ),
    );
  }
}
