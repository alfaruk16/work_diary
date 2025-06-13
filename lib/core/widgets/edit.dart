import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color? bgColor, iconColor, borderColor, shadowColor;
  final VoidCallback press;
  final double iconSize;

  const ActionButton(
      {Key? key,
      required this.icon,
      required this.press,
      this.bgColor = bWhite,
      this.iconColor = bGray,
      this.borderColor = const Color(0XFFF4F4F4),
      this.shadowColor = bWhite,
      this.iconSize = 22})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor!),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 0,
            color: shadowColor!.withOpacity(0.59),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: press,
          child: Icon(icon, color: iconColor, size: iconSize),
        ),
      ),
    );
  }
}
