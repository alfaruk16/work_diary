import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/visit_info.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class SlotView extends StatelessWidget {
  const SlotView(
      {super.key,
      required this.slot,
      required this.edit,
      required this.complete});

  final Slot slot;
  final VoidCallback edit;
  final VoidCallback complete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const TextB(
          text: 'Visit Slot',
          textStyle: bHeadline5,
        ),
        const SizedBox(height: 5),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            decoration: BoxDecoration(
              color: bBlue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                SlotViewDetails(slot: slot),
                Column(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFFCED8FA),
                          ),
                          color: const Color(0XFFECF0FE),
                          borderRadius: BorderRadius.circular(3)),
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: edit,
                          icon: const Icon(Icons.edit),
                          color: bLightGray),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFFCED8FA),
                          ),
                          color: const Color(0XFFECF0FE),
                          borderRadius: BorderRadius.circular(3)),
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: complete,
                          icon: const Icon(Icons.check_box),
                          color: bGreen),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}

class SlotViewDetails extends StatelessWidget {
  const SlotViewDetails({super.key, required this.slot});

  final Slot slot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: slot.slotDetails!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return VisitInfo(
                  info:
                      "${slot.slotDetails![index].name!} : ${slot.slotDetails![index].value!}");
            }));
  }
}
