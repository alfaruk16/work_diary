import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/order_note/bloc/order_note_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/chips.dart';
import 'package:work_diary/core/widgets/text.dart';

class NoteList extends StatelessWidget {
  final List listData;
  const NoteList({
    Key? key,
    this.listData = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderNoteBloc, OrderNoteState>(
        builder: (context, state) {
      final bloc = context.read<OrderNoteBloc>();
      return Container(
        decoration: BoxDecoration(
          color: bWhite,
          border: Border.all(
            color: const Color(0XFFDBDBDB),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: List.generate(
            listData.length,
            (index) => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  bloc.add(GoToOrderNotePlanList(listData[index]["status"]));
                },
                child: Ink(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0XFFDBDBDB),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextB(
                              text: listData[index]["plan_no"],
                              textStyle: bBody4,
                              fontColor: bDarkGray,
                            ),
                          ),
                          ChipsB(
                            text: listData[index]["status"],
                            type: listData[index]["status"],
                          ),
                        ],
                      ),
                      TextB(
                        text: listData[index]["title"],
                        maxLines: 1,
                        textStyle: bBody1,
                        fontWeight: FontWeight.w500,
                      ),
                      TextB(
                        text: listData[index]["date"],
                        textStyle: bBody4,
                        fontColor: bDarkGray,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SvgPicture.asset(
                            onGoingVisitSvg,
                            width: 14,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: TextB(
                              text: listData[index]["shop_name"],
                              textStyle: bBody4,
                              fontColor: bDark,
                            ),
                          ),
                          const Icon(
                            Icons.more_vert,
                            color: bGray,
                            size: 17,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TextB(
                            text: "priority: ",
                            fontSize: 12,
                            fontColor: bDarkGray,
                          ),
                          ChipsB(
                            text: listData[index]["priority"],
                            type: listData[index]["priority"],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
