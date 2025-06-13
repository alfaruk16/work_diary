import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'widgets.dart';

class ChipsB extends StatelessWidget {
  final String? text, type;

  const ChipsB({
    Key? key,
    this.text = "Chips",
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorType(type).withOpacity(0.12),
        border: Border.all(color: colorType(type).withOpacity(0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextB(
        text: text!,
        fontColor: colorType(type),
        textStyle: bBody4,
      ),
    );
  }

  Color colorType(String? type) {
    if (type == "Complete" || type == "Approved") {
      return bGreen;
    } else if (type == "Ongoing") {
      return const Color(0XFF1D68F5);
    } else if (type == "Cancel") {
      return bLightRed;
    } else if (type == "Pending") {
      return bDark;
    } else if (type == "Approval Waiting") {
      return const Color(0XFFDEA60C);
    } else if (type == "Not yet checking") {
      return const Color(0XFF1D68F5);
    } else if (type == "Postpone") {
      return const Color(0XFFF2416C);
    } else if (type == "Not Complete") {
      return const Color(0XFF7B49A2);
    } else if (type == "Low") {
      return const Color(0XFF1867C0);
    } else if (type == "Urgent") {
      return const Color(0XFF3BAF40);
    } else if (type == "Medium") {
      return const Color(0XFFF38A04);
    } else if (type == "Cancelled") {
      return const Color(0XFFF2416C);
    }
    return bDark;
  }
}
