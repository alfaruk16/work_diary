import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class NotificationMsgList extends StatelessWidget {
  final int itemCount;
  final Color? leadingIconBg;
  final IconData? leadingIcon;
  final String? title, subTitle;
  final bool? isReaded;
  final VoidCallback? press;
  const NotificationMsgList({
    Key? key,
    this.leadingIconBg = const Color(0XFFEEF9FD),
    this.leadingIcon = Icons.add_chart,
    this.title = "title",
    this.subTitle = "Sub title",
    this.isReaded = true,
    this.press,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Ink(
          decoration: BoxDecoration(
              color: isReaded! ? const Color(0XFFFAFDFF) : bWhite,
              border: const Border(
                  bottom: BorderSide(width: 1, color: Color(0XFFDBDBDB)))),
          child: ListTile(
            onTap: press,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: leadingIconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                leadingIcon,
                size: 20,
                color: bSkyBlue,
              ),
            ),
            trailing: isReaded!
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: bBlue,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
            title: TextB(
              text: title!,
              fontSize: 13,
              maxLines: 2,
            ),
            subtitle: TextB(
              fontColor: bGray,
              text: subTitle!,
              fontSize: 12,
              fontHeight: 1.7,
            ),
          ),
        );
      },
    );
  }
}
