import 'dart:io';
import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/show_image_file.dart';

class ImageFileB extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit boxFit;
  const ImageFileB(
      {Key? key,
      required this.image,
      this.height,
      this.width,
      this.boxFit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showImageFile(context, imageUrl: image);
      },
      child: SizedBox(
        height: height,
        width: width,
        child: ImageFileView(image: image, boxFit: boxFit),
      ),
    );
  }
}

class ImageFileView extends StatelessWidget {
  const ImageFileView(
      {super.key, required this.image, this.boxFit = BoxFit.cover});

  final String image;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: FileImage(File(image)),
      fit: boxFit,
      frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return SizedBox(
              width: double.infinity, height: double.infinity, child: child);
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: frame != null
              ? SizedBox(
                  width: double.infinity, height: double.infinity, child: child)
              : Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: double.infinity,
                  child: const CircularProgressIndicator(
                      color: bGray, strokeWidth: 10)),
        );
      }),
    );
  }
}
