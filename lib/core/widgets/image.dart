import 'package:flutter/material.dart';
import 'package:work_diary/core/widgets/show_image_file.dart';

class ImageB extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Alignment? alignment;
  const ImageB(
      {Key? key,
      required this.image,
      this.height,
      this.width,
      this.boxFit,
      this.alignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showImageFile(context, imageUrl: image);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: alignment,
          child: SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              image,
              fit: boxFit,
            ),
          ),
        ));
  }
}
