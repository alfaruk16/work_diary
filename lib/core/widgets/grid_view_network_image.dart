import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/network_image.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class GridViewNetworkImage extends StatelessWidget {
  final int crossAxisCount;
  final List<VisitImage?> images;
  final double padding;
  const GridViewNetworkImage({
    Key? key,
    this.crossAxisCount = 5,
    this.images = const [],
    this.padding = 15,
  }) : super(key: key);

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
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: bGray),
                    borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(8),
                  child: NetworkImageB(imageUrl: images[index]!.img!),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
