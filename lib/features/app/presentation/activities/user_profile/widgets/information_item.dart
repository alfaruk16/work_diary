import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class InformationItem extends StatelessWidget {
  final String? titleText, valueText;
  const InformationItem({
    Key? key,
    this.titleText = "Title Text",
    this.valueText = "Value Text",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 112,
              child: TextB(text: titleText!),
            ),
            const SizedBox(
              width: 10,
              child: TextB(text: ":"),
            ),
            Expanded(
              child: TextB(
                text: valueText!,
                fontColor: bBlack,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
