import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/edit.dart';
import 'package:work_diary/core/widgets/text.dart';

class AddedOrderItem extends StatelessWidget {
  const AddedOrderItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0XFFF7F9FC),
          border: Border.all(
            color: const Color(0XFFD3D3D3),
          ),
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    items("Brand:", "Monalica"),
                    items("Product Type:", "Wall Tile"),
                    items("Product Size:", "35x35 25"),
                    items("Quantity Box:", "25"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Column(
                  children: [
                    ActionButton(
                      iconColor: bWhite,
                      bgColor: bGreen,
                      borderColor: const Color(0XFFDFF1FA),
                      shadowColor: bGreen,
                      icon: Icons.edit_sharp,
                      press: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row items(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: TextB(text: title),
        ),
        Expanded(
          child: TextB(
            text: value,
            fontColor: bBlack,
          ),
        ),
      ],
    );
  }
}
