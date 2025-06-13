import 'package:flutter/material.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/profile_image.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/profile_info.dart';
import 'package:work_diary/core/utils/colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    this.size = 55,
    this.borderColor = Colors.white,
    this.image,
    this.greetingText,
    this.userName = "",
    this.title = "",
    this.icon,
    this.fontColor,
    this.isRowHeader = true,
    this.press,
  }) : super(key: key);

  final String? greetingText, userName, title;
  final String? image;
  final double? size;
  final Color? borderColor, fontColor;
  final Icon? icon;
  final bool? isRowHeader;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        color: isRowHeader! ? const Color(0XFF42B9E0) : Colors.white,
        child: isRowHeader!
            ? Row(
                children: [
                  ProfileImage(
                    size: size!,
                    color: borderColor!,
                    image: image,
                  ),
                  const SizedBox(width: 12),
                  ProfileInfo(
                    isRowHeader: isRowHeader,
                    greeting: greetingText,
                    name: userName,
                    icon: icon,
                    title: title,
                    fontColor: fontColor,
                  ),
                ],
              )
            : Column(
                children: [
                  ProfileImage(
                    size: size!,
                    color: bLightGray,
                    image: image,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileInfo(
                        isRowHeader: isRowHeader,
                        greeting: greetingText,
                        name: userName,
                        icon: icon,
                        title: title,
                        fontColor: const Color(0XFF3B4B5C),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
