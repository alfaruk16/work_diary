import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';

class VisitSlot extends StatelessWidget {
  const VisitSlot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextB(
          text: "Visit Slot",
          textStyle: bHeadline5,
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          decoration: BoxDecoration(
            color: bBlue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              const Flexible(
                child: VisitInfo(
                  iconName: visitStatusSvg,
                  title: "Slot Start",
                  info: "Date",
                  infoColor: bDarkBlue,
                ),
              ),
              const Flexible(
                child: VisitInfo(
                  iconName: visitStatusSvg,
                  title: "Slot Start",
                  info: "Date",
                  infoColor: bDarkBlue,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0XFFCED8FA),
                    ),
                    color: const Color(0XFFECF0FE),
                    borderRadius: BorderRadius.circular(3)),
                child: const Icon(Icons.edit, size: 18, color: bLightGray),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
