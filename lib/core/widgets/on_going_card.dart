import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class OnGoingVisitCard extends StatelessWidget {
  const OnGoingVisitCard({
    super.key,
    required this.onGoingVisit,
    required this.goToOngoingScreen,
  });

  final VisitData onGoingVisit;
  final Function goToOngoingScreen;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          goToOngoingScreen(onGoingVisit.status, onGoingVisit);
        },
        borderRadius: BorderRadius.circular(8),
        child: DottedBorder(
          options: RectDottedBorderOptions(
            color: bGreen,
            strokeWidth: 1.5,
            dashPattern: const [4, 3],
            padding: const EdgeInsets.all(1),
          ),
          child: Ink(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0XFFF9F9FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(height: 60, child: Image.asset(onGoingVisitPng)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 2),
                              child: TextB(
                                text: "${onGoingVisit.name}",
                                maxLines: 1,
                                fontColor: bBlack,
                                textStyle: bHeadline5,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 25,
                            color: bGray,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.alarm_on,
                                size: 17,
                                color: bGreen,
                              ),
                              const SizedBox(width: 5),
                              TextB(
                                text: "${onGoingVisit.startedAt}",
                                maxLines: 1,
                                fontColor: bDarkGray,
                                textStyle: bBody2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 3),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: bGreen,
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextB(
                            text: "${onGoingVisit.status}",
                            maxLines: 1,
                            fontColor: bDarkGray,
                            fontSize: 15,
                          ),
                          const Spacer(),
                          TextB(
                            text: "Ref#  ${onGoingVisit.id}",
                            fontSize: 12,
                            fontColor: bDarkGray,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
