import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/text.dart';

class PlanStatusCard extends StatelessWidget {
  const PlanStatusCard({
    Key? key,
    this.color = bBlue,
  }) : super(key: key);
  final Color? color;
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
              color: const Color(0XFF2D76FE),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TextB(
                  text: "Total Visit Plan for Today",
                  textStyle: bStyle,
                  fontColor: bWhite,
                ),
                TextB(
                  text: "12 visit",
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
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0XFF1349FF),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      onGoingVisitSvg,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Wrap(
                    children: List.generate(
                      6,
                      (index) => Padding(
                        padding:
                            const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        child: RichText(
                          text: const TextSpan(
                            text: '01 ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'Ongoing',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
