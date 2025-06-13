import 'package:flutter/material.dart';
import 'package:work_diary/features/app/presentation/activities/attendance/widgets/visit_history.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/text.dart';

Future showDialogueB(BuildContext context) {

  final size = MediaQuery.of(context).size;

  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      clipBehavior: Clip.none,
      contentPadding: const EdgeInsets.all(0.0),
      titlePadding: const EdgeInsets.all(0.0),
      actionsPadding: const EdgeInsets.all(0.0),
      title: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: bLightBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.chevron_left,
                  color: bWhite,
                  size: 30,
                ),
                TextB(
                  text: "27, Jun 2022",
                  fontColor: bWhite,
                  textStyle: bHeadline4,
                ),
                Icon(
                  Icons.chevron_right,
                  color: bWhite,
                  size: 30,
                ),
              ],
            ),
          ),
          Positioned(
            top: -43,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0XFF333741),
                  shape: BoxShape.circle,
                ),
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.close,
                  color: bWhite,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ButtonB(
          text: "OK",
          press: () {
            Navigator.pop(context);
          },
          shadow: false,
          bgColor: bDark,
          textColor: bWhite,
        )
      ],
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size.height * 0.65,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: bInputstroke),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Working hours: ",
                            style: TextStyle(
                              fontSize: 13,
                              color: bDarkGray,
                            ),
                            children: [
                              TextSpan(
                                text: "08:00 h",
                                style: TextStyle(
                                  color: bLightBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: "Office time: ",
                            style: TextStyle(
                              fontSize: 13,
                              color: bDarkGray,
                            ),
                            children: [
                              TextSpan(
                                text: "09:00 am ",
                                style: TextStyle(color: bGreen),
                              ),
                              TextSpan(
                                text: "to ",
                              ),
                              TextSpan(
                                text: "06:00 pm",
                                style: TextStyle(color: bGreen),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: RichText(
                      text: const TextSpan(
                        text: "Working hours \n",
                        style: TextStyle(
                          fontSize: 13,
                          color: bDarkGray,
                        ),
                        children: [
                          TextSpan(
                            text: "8h:10m",
                            style: TextStyle(
                              fontSize: 16,
                              color: bBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextB(
                      text: "Check In / Check Out Historyy",
                      fontColor: bDarkGray,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: "Check In: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: bDark,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "10:30 am",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: bBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.pin_drop,
                                    size: 20,
                                    color: Color(0XFF1D68F5),
                                  ),
                                  Flexible(
                                    child: TextB(
                                      text: " Badda Link road, gulshan-1",
                                      fontSize: 13,
                                      fontHeight: 1.2,
                                      fontColor: bGray,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: "Check Out: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: bDark,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "07:16 am",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: bBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.pin_drop,
                                    size: 20,
                                    color: Color(0XFF1D68F5),
                                  ),
                                  Flexible(
                                    child: TextB(
                                      text: " Rampura Kaca Bazar",
                                      fontSize: 13,
                                      fontHeight: 1.2,
                                      fontColor: bGray,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const VisitHistory(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
