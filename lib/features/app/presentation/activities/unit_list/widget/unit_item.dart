import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/units.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({
    Key? key,
    required this.itemIndex,
    required this.units,
    required this.press,
  }) : super(key: key);

  final UnitResponse units;
  final int itemIndex;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        press(units.data![itemIndex]);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: units.data!.length != (itemIndex + 1)
                  ? const Color(0XFFE1E1E3)
                  : Colors.transparent),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextB(
                    text: units.data![itemIndex].name!,
                    textStyle: bHeadline5,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        visitMapSvg,
                        width: 15,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: TextB(
                          text: units.data![itemIndex].location!,
                          fontSize: 12,
                          fontColor: bDarkGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        visitNoteSvg,
                        width: 15,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: TextB(
                          text: units.data![itemIndex].address!,
                          fontSize: 12,
                          fontColor: bDarkGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        mobileSvg,
                        width: 15,
                      ),
                      const SizedBox(width: 5),
                      TextB(
                        text: units.data![itemIndex].mobile!,
                        fontSize: 12,
                        fontColor: bDarkGray,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0XFFF9F9FB),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.chevron_right,
                color: bGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
