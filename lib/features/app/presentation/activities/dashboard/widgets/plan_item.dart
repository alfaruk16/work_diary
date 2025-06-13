import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/widgets/text.dart';

class PlanItem extends StatelessWidget {
  const PlanItem(
      {super.key,
      this.width,
      this.image = '',
      this.number = '0',
      this.name = '',
      this.borderColor = const Color(0XFFE1E1E3),
      this.backgroundColor = const Color(0XFFEAE9EE),
      this.textColor = Colors.black,
      required this.press});

  final double? width;
  final String image;
  final String number;
  final String name;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          press();
        },
        child: Container(
          width: width ?? size.width / 2 - 25,
          height: size.width / 5,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  SvgPicture.asset(image),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextB(
                        text: number,
                        fontSize: 20,
                        fontColor: const Color(0XFF0D3FE9),
                        fontWeight: FontWeight.bold,
                      ),
                      TextB(text: name, fontSize: 13, fontColor: textColor),
                    ],
                  )),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ));
  }
}

class PlanItemAdd extends StatelessWidget {
  const PlanItemAdd({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          press();
        },
        child: Container(
          width: size.width / 4,
          height: size.width / 5,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0XFF93F5E8)),
              color: const Color(0XFFF1FDFA),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_circle,
                size: 36,
                color: Color(0XFF11B09B),
              ),
              SizedBox(height: 5),
              TextB(
                  text: "Make Plan",
                  fontSize: 13,
                  fontColor: Color(0XFF11B09B)),
            ],
          ),
        ));
  }
}
