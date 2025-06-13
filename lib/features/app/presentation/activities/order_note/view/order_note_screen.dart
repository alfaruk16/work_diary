import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/data/note.dart';
import 'package:work_diary/features/app/presentation/activities/order_note/bloc/order_note_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/order_note/widgets/note_list.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/plan_status_card.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class OrderNoteScreen extends StatelessWidget {
  const OrderNoteScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const OrderNoteScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderNoteBloc(getIt<IFlutterNavigator>()),
      child: const OrderNoteView(),
    );
  }
}

class OrderNoteView extends StatelessWidget {
  const OrderNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OrderNoteBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<OrderNoteBloc, OrderNoteState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Order Note",
        bottomSection: ButtonB(
          press: () {
            bloc.add(GoToCreateOrderNoteScreen());
          },
          text: "Create New Order Note",
          bgColor: bGreen,
          textColor: bWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width / 2 - 30,
                  child: DropdownSearchB(
                    items: const [DropdownItem(name: 'Select', value: -1)],
                    selected: (index) {},
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - 30,
                  child: TextFieldB(
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        size: 25,
                        color: bSkyBlue,
                      ),
                      hintText: "01 July 2022",
                      controller: state.dateController,
                      focusNode: state.dateFocusNode,
                      onChanged: (value) {}),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const PlanStatusCard(
              color: bGreen,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: bWhiteGray,
                border: Border.all(color: const Color(0XFFDBDBDB)),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextB(
                      text: "Order Note for this week",
                      textStyle: bHeadline5,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  NoteList(
                    listData: note,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
