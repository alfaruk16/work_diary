import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/date.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';

class PlanList extends StatelessWidget {
  const PlanList(
      {Key? key,
      required this.planList,
      required this.goToDetailsScreen,
      required this.isLoading,
      required this.isEndList,
      this.changeStatus,
      this.listTitle,
      this.isSupervisor = false})
      : super(key: key);

  final List<VisitData> planList;
  final String? listTitle;
  final Function goToDetailsScreen;
  final Function? changeStatus;
  final bool isLoading;
  final bool isEndList, isSupervisor;

  @override
  Widget build(BuildContext context) {
    return planList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (listTitle != null)
                TextB(
                  text: listTitle!,
                  textStyle: bSubtitle1,
                  fontColor: bGray,
                ),
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
                              borderRadius: BorderRadius.circular(7),
                              onTap: () {
                                goToDetailsScreen(
                                    planList[index].status, planList[index]);
                              },
                              highlightColor: bGray.withOpacity(0.2),
                              splashColor: bGray.withOpacity(0.3),
                              child: Ink(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: planList[index].status != "Completed"
                                      ? bWhite
                                      : const Color(0xFFE7FFED),
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color:
                                          planList[index].status != "Completed"
                                              ? const Color(0XFFE1E1E3)
                                              : const Color(0xFF9DE5B0)),
                                ),
                                child: Row(
                                  children: [
                                    // TextB(text: 'Visit Ref: ${planList[index].id}', fontSize: 12),
                                    // const SizedBox(height: 5),
                                    planList[index].status == "Completed" ||
                                            planList[index].status == "On Going"
                                        ? VisitStatus(visit: planList[index])
                                        : const SizedBox(
                                            width: 55,
                                            child: TextB(
                                              text: "Visit\n not\n Started",
                                              alignMent: TextAlign.center,
                                              fontSize: 13,
                                            )),
                                    dashedLine(index),
                                    listMid(index, isSupervisor),
                                    const SizedBox(width: 10),
                                    listRight(index),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
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
                                text: "You've reached the end of the list"),
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
        : Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: const TextB(text: "You Don't have any visit plan"));
  }

  SizedBox dashedLine(int index) {
    return SizedBox(
      width: 30,
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              border: Border.all(
                color: planList[index].status != "completed" ? bGray : bGreen,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          Expanded(
            child: DottedLine(
              direction: Axis.vertical,
              dashColor: getStatusColor(planList[index].status),
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: getStatusColor(planList[index].status),
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ],
      ),
    );
  }

  Expanded listMid(int index, bool isSupervisor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextB(
            text: planList[index].name ?? '',
            fontSize: 16,
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
              Flexible(
                child: TextB(
                  text: planList[index].unitName ?? '',
                  maxLines: 1,
                  fontSize: 13,
                  fontColor: bDarkGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // const ChipsB(
              //   text: "Own",
              //   type: "Not Complete",
              // ),
              if (isSupervisor && planList[index].forOwn!)
                const TextB(
                  text: "Own",
                  fontColor: bBlue,
                )
            ],
          ),
        ],
      ),
    );
  }

  Column listRight(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (planList[index].btns!.isNotEmpty)
          PopupMenuButton(
            child: Container(
              alignment: Alignment.topRight,
              // padding: const EdgeInsets.all(4.0),
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
                        planList[index].btns![btnIndex]!.value!);
                  },
                  height: 35,
                  child: TextB(text: planList[index].btns![btnIndex]!.name!),
                ),
              ),
            ],
          ),
        const Spacer(),
        TextB(
          text: "Ref# ${planList[index].id}",
          fontSize: 12,
          fontColor: bDarkGray,
        ),
        const SizedBox(height: 4),
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
    if (status == 'Completed') {
      return bGreen;
    } else if (status == 'Approved') {
      return bBlue;
    } else if (status == 'Postponed') {
      return const Color(0XFFF2416C);
    } else if (status == 'Cancel') {
      return bDarkRed;
    } else if (status == 'Waiting For Approval') {
      return const Color(0XFFC89200);
    } else if (status == 'Cancelled') {
      return const Color(0xFFE33F3B);
    } else if (status == 'Incomplete') {
      return const Color(0xFFFB8C00);
    } else if (status == 'On Going') {
      return bBlue;
    }
    return bGray;
  }
}

class VisitStatus extends StatelessWidget {
  const VisitStatus({Key? key, required this.visit}) : super(key: key);

  final VisitData visit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextB(
              text: visit.startedTime ?? '',
              fontSize: 13,
            ),
            TextB(
              text: visit.completedTime ?? 'Not end',
              fontSize: 13,
            ),
          ],
        ));
  }
}
