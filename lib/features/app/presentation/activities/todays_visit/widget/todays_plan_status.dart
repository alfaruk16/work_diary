import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/today_visit_plan_response.dart';

class TodaysPlanStatus extends StatelessWidget {
  const TodaysPlanStatus({Key? key, this.color = bBlue, required this.summery})
      : super(key: key);
  final Color? color;
  final Summery summery;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
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
              color: const Color(0XFF2D76FE),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextB(
                  text: "Total Visits",
                  textStyle: bStyle,
                  fontColor: bWhite,
                ),
                TextB(
                  text:
                      "${summery.total} visit${summery.total! > 1 ? 's' : ''}",
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
                    color: const Color(0XFF1349FF),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      onGoingVisitSvg,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                          text: "Not available any visit",
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
