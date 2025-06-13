import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';

class Ttile extends StatelessWidget {
  final String? title, titlLinkText;
  final VoidCallback? press;
  const Ttile({
    Key? key,
    this.title = "this is title",
    this.titlLinkText,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextB(
              text: title!,
              fontColor: bBlack,
              textStyle: bHeadline5,
            ),
            if (titlLinkText != null)
              InkWell(
                onTap: press,
                child: TextB(
                  text: titlLinkText!,
                  fontColor: bBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
          ],
        ),
        const Divider(
          height: 5,
          thickness: 1,
          color: bGray,
        ),
      ],
    );
  }
}
