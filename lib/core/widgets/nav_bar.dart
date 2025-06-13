import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';

class NavBarB extends StatelessWidget {
  const NavBarB({super.key, required this.items, required this.activeIndex});

  final List<NavItem> items;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      color: Colors.white,
      height: 65,
      circleWidth: 54,
      iconDurationMillSec: 0,
      activeIndex: activeIndex,
      circleShadowColor: Colors.black.withOpacity(0.25),
      shadowColor: Colors.black.withOpacity(0.25),
      elevation: 8,
      cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      activeIcons: [
        ...List.generate(
            items.length,
            (index) => InkWell(
                  onTap: items[index].onTap,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(
                        items[index].icon,
                        width: 30,
                        colorFilter: index == activeIndex
                            ? const ColorFilter.mode(bBlue, BlendMode.srcIn)
                            : const ColorFilter.mode(bGray, BlendMode.srcIn),
                      ),
                      Positioned(
                        bottom: -23,
                        child: TextB(
                            text: items[index].name,
                            fontSize: 14,
                            fontColor: bGray),
                      )
                    ],
                  ),
                )),
      ],
      inactiveIcons: [
        ...List.generate(
          items.length,
          (index) => InkWell(
            onTap: items[index].onTap,
            child: Column(
              children: [
                const SizedBox(height: 13),
                SvgPicture.asset(items[index].icon,
                    colorFilter: index == activeIndex
                        ? const ColorFilter.mode(bBlue, BlendMode.srcIn)
                        : const ColorFilter.mode(bGray, BlendMode.srcIn),
                    width: 23),
                const SizedBox(height: 6),
                TextB(
                  text: items[index].name,
                  fontSize: 14,
                  fontColor: bGray,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NavItem {
  const NavItem(
      {required this.name,
      required this.icon,
      this.textColor,
      this.iconColor,
      required this.onTap});

  final String name;
  final String icon;
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback onTap;
}
