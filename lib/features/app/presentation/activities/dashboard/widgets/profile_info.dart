import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';

class ProfileInfo extends StatelessWidget {
  final String? greeting, name, title;
  final Color? fontColor;
  final Icon? icon;
  final bool? isRowHeader;
  const ProfileInfo({
    Key? key,
    this.greeting = "",
    this.name = "",
    this.title = "",
    this.icon,
    this.isRowHeader = true,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            isRowHeader! ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (greeting != null)
            TextB(
              text: greeting!,
              textStyle: bBody4,
              fontColor: fontColor,
            ),
          Row(
            mainAxisAlignment: isRowHeader!
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextB(
                  text: name!,
                  fontSize: 18,
                  fontColor: fontColor ?? Colors.white,
                  fontHeight: 1,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 5),
          TextB(
            text: title!,
            fontColor: fontColor ?? const Color(0XFFF2F2F2),
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}
