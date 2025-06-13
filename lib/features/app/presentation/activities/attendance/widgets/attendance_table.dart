import 'package:flutter/material.dart';
import 'package:work_diary/features/app/presentation/activities/attendance/widgets/modal.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text.dart';

class AttendanceTable extends StatelessWidget {
  final List attendanceList;
  const AttendanceTable({
    Key? key,
    required this.attendanceList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0XFFDBDBDB),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          //table header==========
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: bWhiteGray,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 70,
                  child: const TextB(
                    text: "Date",
                    alignMent: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextB(text: "Check In"),
                      TextB(text: "Check Out")
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),

          //table Body Item

          ...List.generate(
            attendanceList.length,
            (index) {
              if (attendanceList[index]["num_of_visit_complete"] != 0) {
                return InkWell(
                  onTap: () {
                    showDialogueB(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: (index == attendanceList.length - 1)
                          ? null
                          : const Border(
                              bottom: BorderSide(color: Color(0XFFDBDBDB)),
                            ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color(0XFFDBDBDB)),
                            ),
                          ),
                          child: Container(
                            width: 42,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                                color: const Color(0XFFF2F2F2),
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextB(
                                  text: attendanceList[index]["date"],
                                  textStyle: bHeadline5,
                                  fontHeight: 1,
                                ),
                                TextB(
                                  text: attendanceList[index]["month"],
                                  fontSize: 12,
                                  fontHeight: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextB(
                                      text: attendanceList[index]["check_in"],
                                      fontColor: bBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    TextB(
                                      text: attendanceList[index]["check_out"],
                                      fontColor: bBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    TextB(
                                      text:
                                          "${attendanceList[index]["num_of_visit"]} Visit plan,",
                                      fontSize: 12,
                                      fontColor: bDarkGray,
                                    ),
                                    TextB(
                                      text:
                                          "${attendanceList[index]["num_of_visit_complete"]} Complete, ",
                                      fontSize: 12,
                                      fontColor: bDarkGray,
                                    ),
                                    TextB(
                                      text:
                                          "${attendanceList[index]["num_of_visit_incomplete"]} Missing, ",
                                      fontSize: 12,
                                      fontColor: bDarkGray,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.chevron_right,
                            color: bExtraLightGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0XFFFFF1F1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      TextB(
                        text: "24 Jun 2022",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: bBlack,
                      ),
                      TextB(
                        text: "No Visit Plan Found of the day",
                        fontSize: 12,
                        fontColor: Color(0XFF6F758A),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
