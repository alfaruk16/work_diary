import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';

class EmergencyTaskStatus extends StatelessWidget {
  const EmergencyTaskStatus(
      {Key? key, this.color = bSkyBlue, required this.summery})
      : super(key: key);
  final Color? color;
  final Summery summery;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 7,
            spreadRadius: 0,
            color: color!.withOpacity(0.57),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0XFF069DCF),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextB(
                  text: "Total Emergency Issue",
                  textStyle: bStyle,
                  fontColor: bWhite,
                ),
                TextB(
                  text: "${summery.total} Issue",
                  textStyle: bHeadline5,
                  fontColor: bWhite,
                )
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0XFF0A99C7),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      onGoingVisitSvg,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: summery.data!.isNotEmpty
                      ? Wrap(
                          children: List.generate(
                            summery.data!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 3, bottom: 3),
                              child: RichText(
                                text: TextSpan(
                                  text: "${summery.data![index].total} ",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: "${summery.data![index].status}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const TextB(
                          text: "No Data Found",
                          fontColor: bWhite,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
