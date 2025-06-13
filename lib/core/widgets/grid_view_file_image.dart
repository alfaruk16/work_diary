import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/core/widgets/image_file.dart';

class GridViewFileImageB extends StatelessWidget {
  final int crossAxisCount;
  final List<ImageFile> images;
  final double padding;
  final Function? cancel;
  const GridViewFileImageB(
      {Key? key,
      this.crossAxisCount = 3,
      this.images = const <ImageFile>[],
      this.padding = 15,
      this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isNotEmpty
        ? GridView.builder(
            padding: EdgeInsets.only(top: padding),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    children: [
                      ImageFileB(image: images[index].file.path),
                      if (cancel != null)
                        Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              cancel!(index);
                            },
                            child: const Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.cancel_outlined)),
                          ),
                        )
                    ],
                  ));
            },
          )
        : const SizedBox();
  }
}
