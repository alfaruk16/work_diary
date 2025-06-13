import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/date.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class IssueList extends StatelessWidget {
  const IssueList(
      {Key? key,
      required this.planList,
      required this.goToDetailsScreen,
      required this.isLoading,
      required this.isEndList,
      this.listTitle,
      this.changeStatus})
      : super(key: key);

  final List<VisitData> planList;
  final String? listTitle;
  final Function goToDetailsScreen;
  final bool isLoading;
  final bool isEndList;
  final Function? changeStatus;

  @override
  Widget build(BuildContext context) {
    return planList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(planList.length + 1, (index) {
                if (index < planList.length) {
                  return Material(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index > 0 &&
                            planList[index].dateFor !=
                                planList[index - 1].dateFor!)
                          DateB(date: planList[index].dateFor!)
                        else if (index == 0)
                          DateB(date: planList[index].dateFor!),
                        const SizedBox(height: 5),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 20),
                          child: IntrinsicHeight(
                            child: InkWell(
                              onTap: () {
                                goToDetailsScreen(
                                    planList[index].status, planList[index]);
                              },
                              highlightColor: Colors.blue.withOpacity(0.4),
                              splashColor: Colors.green.withOpacity(0.5),
                              child: Ink(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: planList[index].status != "completed"
                                      ? bWhite
                                      : const Color(0xFFE7FFED),
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color:
                                          planList[index].status != "completed"
                                              ? const Color(0XFFE1E1E3)
                                              : const Color(0xFF9DE5B0)),
                                ),
                                child: Row(
                                  children: [
                                    TextB(
                                      text: "${index + 1}",
                                      textStyle: bHeadline5,
                                      fontSize: 18,
                                      fontColor: bDarkGray,
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30,
                                        height: 85,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      planList[index].status !=
                                                              "completed"
                                                          ? bGray
                                                          : bGreen,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                              ),
                                            ),
                                            Expanded(
                                              child: DottedLine(
                                                direction: Axis.vertical,
                                                dashColor: getStatusColor(
                                                    planList[index].status),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: getStatusColor(
                                                    planList[index].status),
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    listMid(index),
                                    listRight(index),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Center(
                      child: Column(
                        children: [
                          if (isEndList)
                            const TextB(
                                text: "You’ve reached the end of the list"),
                        ],
                      ),
                    ),
                  );
                }
              }),
              if (!isEndList)
                Container(
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: isLoading
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator())
                        : const SizedBox())
            ],
          )
        : const Center(child: TextB(text: "No Data Found"));
  }

  Expanded listMid(int index) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextB(
            text: 'Task Ref# ${planList[index].id!}',
            fontSize: 14,
            fontColor: bDarkGray,
          ),
          const SizedBox(height: 3),
          TextB(
            text: planList[index].name!,
            fontSize: 16,
            fontHeight: 1,
            maxLines: 1,
            fontColor: bBlack,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              SvgPicture.asset(
                onGoingVisitSvg,
                width: 16,
              ),
              const SizedBox(
                width: 7,
              ),
              const Flexible(
                child: TextB(
                  text: "Enayet & Brothers",
                  maxLines: 1,
                  fontSize: 13,
                  fontColor: bDarkGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: TextB(
                  text: "Committed to complete this issue",
                  maxLines: 1,
                  fontSize: 13,
                  fontColor: bBlack,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3,
                ),
                child: TextB(
                  text: "${planList[index].created}",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontColor: bBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              if (planList[index].status == "completed")
                const Icon(
                  Icons.done,
                  size: 19,
                  color: bGreen,
                ),
              TextB(
                text: "${planList[index].status}",
                fontSize: 14,
                fontColor: getStatusColor(planList[index].status),
              ),
              const Spacer(),
              if (planList[index].forOwn!)
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: TextB(
                    text: "Own",
                    fontSize: 14,
                    fontColor: bGreen,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Column listRight(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (planList[index].btns!.isNotEmpty)
          PopupMenuButton(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: const Icon(
                  Icons.more_vert,
                  size: 18,
                  color: bGray,
                ),
              ),
              itemBuilder: (context) => [
                    ...List.generate(
                      planList[index].btns!.length,
                      (btnIndex) => PopupMenuItem(
                        onTap: () {
                          changeStatus!(planList[index].id,
                              planList[index].btns![btnIndex]!.value);
                        },
                        height: 35,
                        child:
                            TextB(text: planList[index].btns![btnIndex]!.name!),
                      ),
                    ),
                  ]),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: bGray.withOpacity(0.2),
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Icon(Icons.chevron_right, size: 20, color: bGray),
        ),
      ],
    );
  }

  Color getStatusColor(status) {
    if (status == 'completed') {
      return bGreen;
    } else if (status == 'cancelled') {
      return const Color(0xFFE33F3B);
    }
    return bGray;
  }
}
