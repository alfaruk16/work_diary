import 'package:flutter/material.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/core/widgets/dropdown_simple.dart';
import 'package:work_diary/core/widgets/network_image.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/performance_report.dart';

class PerformanceHeader extends StatelessWidget {
  const PerformanceHeader(
      {Key? key,
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
      required this.performanceReport,
      required this.selectedMonth,
      required this.months,
      required this.selected})
      : super(key: key);

  final String? greetingText, userName, title;
  final String? image;
  final double? size;
  final Color? borderColor, fontColor;
  final Icon? icon;
  final bool? isRowHeader;
  final VoidCallback? press;
  final PerformanceReport performanceReport;
  final List<DropdownItem> months;
  final int selectedMonth;
  final Function selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0XFFEEEEEE)),
            color: const Color(0XFFF5F4F7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0XFFABADB4), width: 2),
                      ),
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size!),
                        child: NetWorkImageViewB(
                          imageUrl: image!,
                          iconSize: size! * .8,
                        ),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextB(text: 'Your monthly target', fontSize: 13),
                      const SizedBox(height: 3),
                      TextB(
                          text:
                              '${performanceReport.data!.performance ?? ''}% Target Completed',
                          fontColor: Colors.black,
                          fontSize: 13),
                    ],
                  )),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 90,
                            padding: const EdgeInsets.only(bottom: 19),
                            child: DropdownSimpleB(
                                items: months,
                                hint: months[0].name,
                                selected: (index) {
                                  selected(index);
                                }),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              if (performanceReport.data!.status != null)
                Container(
                  decoration: BoxDecoration(
                      color: performanceReport.data!.status! == 'poor'
                          ? Colors.red
                          : performanceReport.data!.status! == 'good'
                              ? Colors.amber
                              : Colors.green,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: TextB(
                    text: performanceReport.data!.status ?? '',
                    fontColor: Colors.white,
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const TextB(text: 'Total Target', fontColor: Colors.black),
                  const SizedBox(width: 8),
                  TextB(
                      text:
                          performanceReport.data!.targetTotal.toString(),
                      fontColor: const Color(0XFF1D68F5),
                      fontSize: 16),
                  const SizedBox(width: 20),
                  const TextB(text: 'Total Completed', fontColor: Colors.black),
                  const SizedBox(width: 8),
                  TextB(
                      text:
                          performanceReport.data!.actualTotal.toString(),
                      fontColor: Colors.green,
                      fontSize: 16),
                ],
              )
            ],
          )),
    );
  }
}
