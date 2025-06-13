import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/edit.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class CompetitorsActivity extends StatelessWidget {
  const CompetitorsActivity({
    Key? key,
    this.editable = true,
    required this.formList,
  }) : super(key: key);

  final bool? editable;
  final List<FormList?>? formList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Divider(
          thickness: 1,
          height: 0,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0XFFEEF4FF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.local_play,
                color: bBlue,
                size: 23,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextB(
                  text: "Competitor's Activity",
                  textStyle: bHeadline5,
                  fontColor: bBlack,
                  fontHeight: 1,
                ),
                TextB(
                  text: "Please do Competitor's Activity",
                  textStyle: bBody3,
                  fontHeight: 1.2,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  items("Company:", "CBC"),
                  items("Activity:", "Display Rack"),
                  items("Impact on Business:", "Increase Sales"),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 150,
                        child: TextB(text: "Upload Photos:"),
                      ),
                      // Expanded(
                      //   child: GridViewB(
                      //     padding: 0,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
            if (editable!)
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Column(
                  children: [
                    ActionButton(
                      icon: Icons.border_color,
                      press: () {},
                    ),
                    ActionButton(
                      icon: Icons.delete_outline,
                      press: () {},
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  items("Company:", "Khadim"),
                  items("Activity:", "Display Rack"),
                  items("Impact on Business:", "Increase Sales"),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 150,
                        child: TextB(text: "Upload Photos:"),
                      ),
                      // Expanded(
                      //   child: GridViewB(
                      //     padding: 0,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
            if (editable!)
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Column(
                  children: [
                    ActionButton(
                      icon: Icons.border_color,
                      press: () {},
                    ),
                    ActionButton(
                      icon: Icons.delete_outline,
                      press: () {},
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget items(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: TextB(text: title),
        ),
        Expanded(
          child: TextB(
            text: value,
            fontColor: bBlack,
          ),
        ),
      ],
    );
  }
}
