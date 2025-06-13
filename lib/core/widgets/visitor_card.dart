import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/widgets.dart';

class VisitorCard extends StatelessWidget {
  const VisitorCard(
      {super.key,
      this.name,
      this.designation,
      this.image,
      this.avatarSize = 75,
      this.isIconBtn = false,
      this.pressToDetails,
      required this.pressToAddVisit});

  final String? name;
  final String? designation;
  final String? image;
  final double avatarSize;
  final bool isIconBtn;

  final VoidCallback? pressToDetails;
  final VoidCallback pressToAddVisit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    pressToDetails!();
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0XFFEEEEEE)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: avatarSize,
                          height: avatarSize,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: bWhite,
                            border: Border.all(color: const Color(0XFFEEEEEE)),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: image == null
                                ? Image.asset(photoPng)
                                : NetWorkImageViewB(
                                    imageUrl: image!, iconSize: 60),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextB(
                            text: name ?? '',
                            textStyle: bHeadline5,
                            fontColor: bBlack,
                            maxLines: 1,
                            alignMent: TextAlign.center),
                        const SizedBox(height: 5),
                        TextB(
                            text: designation ?? '',
                            fontSize: 12,
                            fontColor: bGray,
                            maxLines: 1,
                            alignMent: TextAlign.center),
                        const Spacer(),
                        if (!isIconBtn)
                          Material(
                            color: bBlue,
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                pressToAddVisit();
                              },
                              child: Container(
                                width: size.width / 3,
                                height: 27,
                                alignment: Alignment.center,
                                child: const TextB(
                                    text: 'Assign visit', fontColor: bWhite),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isIconBtn)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    pressToAddVisit();
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: bBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 24,
                      color: bWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
