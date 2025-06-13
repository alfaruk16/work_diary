import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';


class VisitHistory extends StatelessWidget {
  const VisitHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: bInputstroke),
            ),
          ),
          child: const TextB(
            text: "Visit History",
            fontSize: 16,
            fontColor: bDarkGray,
          ),
        ),
        ...List.generate(
          10,
          (index) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: bInputstroke),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextB(
                        text: "Visit plan - 01",
                        fontColor: bBlack,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: const [
                          TextB(
                            text: "Saha Tiles: ",
                          ),
                          Flexible(
                            child: TextB(
                              text:
                                  "(Badda Link road, guls Badda Link road, guls)",
                              fontColor: bGray,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: const [
                    TextB(
                      text: "Visit Time",
                      fontSize: 12,
                      fontColor: bDarkGray,
                    ),
                    TextB(
                      text: "07:16 am",
                      fontWeight: FontWeight.w500,
                      fontColor: bBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
