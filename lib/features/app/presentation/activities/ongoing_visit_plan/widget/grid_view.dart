import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class GridViewB extends StatelessWidget {
  final int crossAxisCount;
  final List<VisitImage> images;
  final double padding;
  const GridViewB({
    Key? key,
    this.crossAxisCount = 5,
    this.images = const <VisitImage>[],
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
              return ClipRRect(
                clipBehavior: Clip.none,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: bGray)),
                  child: Image.network(
                    '${images[index].img}',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )
        : GridView.builder(
            padding: EdgeInsets.only(top: padding),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Icon(
                    Icons.image,
                    size: MediaQuery.of(context).size.width / 5,
                    color: Colors.black.withOpacity(.75),
                  ));
            },
          );
  }
}
