import 'package:flutter/material.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/performance_report.dart';

class PerformanceItem extends StatelessWidget {
  const PerformanceItem({super.key, required this.detail});

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0XFFD3D3D3)),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Container(
                  width: size.width,
                  color: const Color(0XFFF8FAFF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextB(
                      text: detail.unitTypeName ?? '',
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black))),
          const Divider(
            thickness: 1.5,
            height: 2,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: detail.formFieldId != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextB(text: 'Own', fontColor: Colors.black),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const TextB(text: 'Target'),
                          const Spacer(),
                          TextB(
                            text: detail.targetOwn != null
                                ? detail.targetOwn.toString()
                                : '',
                          ),
                        ],
                      ),
                      const Divider(
                        height: 8,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const TextB(text: 'Completed'),
                          const Spacer(),
                          TextB(
                            text: detail.actualOwn != null
                                ? detail.actualOwn.toString()
                                : '',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TextB(text: 'Competitor', fontColor: Colors.black),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const TextB(text: 'Target'),
                          const Spacer(),
                          TextB(
                            text: detail.targetCompetitor != null
                                ? detail.targetCompetitor.toString()
                                : '',
                          ),
                        ],
                      ),
                      const Divider(
                        height: 8,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const TextB(text: 'Completed'),
                          const Spacer(),
                          TextB(
                            text: detail.actualCompetitor != null
                                ? detail.actualCompetitor.toString()
                                : '',
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TextB(text: 'Total Target'),
                          const Spacer(),
                          TextB(
                            text: detail.targetTotal != null
                                ? detail.targetTotal.toString()
                                : '',
                          ),
                        ],
                      ),
                      const Divider(
                        height: 8,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const TextB(text: 'Total Completed'),
                          const Spacer(),
                          TextB(
                            text: detail.actualTotal != null
                                ? detail.actualTotal.toString()
                                : '',
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
