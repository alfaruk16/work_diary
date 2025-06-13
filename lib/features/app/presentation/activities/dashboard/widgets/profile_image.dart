import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/network_image.dart';

class ProfileImage extends StatelessWidget {
  final String? image;
  final double? size;
  final Color? color;
  const ProfileImage({
    Key? key,
    this.size = 55,
    this.color = bLightGray,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size!,
      height: size!,
      padding: EdgeInsets.all(size! * 0.05),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color!),
      ),
      child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color!.withOpacity(.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size!),
            child: NetWorkImageViewB(
              imageUrl: image!,
              iconSize: size! * .8,
            ),
          )),
    );
  }
}
