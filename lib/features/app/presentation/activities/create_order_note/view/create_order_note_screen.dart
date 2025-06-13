import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/presentation/activities/create_order_note/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/create_order_note/widgets/added_order_item.dart';
import 'package:work_diary/features/app/presentation/activities/create_order_note/widgets/new_order_item.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/radio_button.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class CreateOrderNoteScreen extends StatelessWidget {
  const CreateOrderNoteScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const CreateOrderNoteScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateOrderNoteBloc(getIt<IFlutterNavigator>()),
      child: const CreateOrderNoteView(),
    );
  }
}

class CreateOrderNoteView extends StatelessWidget {
  const CreateOrderNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateOrderNoteBloc>();

    return BlocBuilder<CreateOrderNoteBloc, CreateOrderNoteState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Create Order Note",
        bottomSection: Column(
          children: [
            ButtonB(
              press: () {
                bloc.add(GoToOrderNoteScreen());
              },
              text: "Save Order Note",
              textColor: bWhite,
              bgColor: bGreen,
              shadow: true,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const TextB(
              text: "Please Create Order Note",
              fontSize: 12,
              fontColor: bBlue,
            ),
            const SizedBox(height: 20),
            const TextB(
              text: "Please select visit Route",
              fontSize: 16,
              fontColor: bDark,
            ),
            const SizedBox(height: 3),
            DropdownSearchB(
              items: const [DropdownItem(name: 'Select', value: -1)],
              selected: (index) {},
            ),
            const SizedBox(height: 20),
            const TextB(
              text: "Select shop",
              fontSize: 16,
              fontColor: bDark,
            ),
            const SizedBox(height: 3),
            DropdownSearchB(
              items: const [DropdownItem(name: 'Select', value: -1)],
              selected: (index) {},
            ),
            const TextB(
              text: "Shop ID: Raj-1",
              fontSize: 14,
              fontColor: bBlue,
            ),
            const SizedBox(height: 30),
            const AddedOrderItem(),
            const SizedBox(height: 20),
            const TextB(
              text: "What's product for order",
              fontSize: 16,
              fontColor: bDark,
            ),
            const SizedBox(height: 3),
            const NewOrderItem(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonB(
                  heigh: 42,
                  fontSize: 16,
                  bgColor: bGreen,
                  textColor: bWhite,
                  shadow: false,
                  text: "+ Add New",
                  press: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TextB(
              text: "Committed to deliver products",
              fontSize: 16,
              fontColor: bDark,
            ),
            const SizedBox(height: 3),
            TextFieldB(
                controller: state.qtyController,
                focusNode: state.qtyFocusNode,
                hintText: "18 July 2022",
                suffixIcon: const Icon(Icons.calendar_month),
                onChanged: (value) {}),
            const SizedBox(height: 25),
            const TextB(
              text: "Priority",
              fontColor: bBlack,
            ),
            const SizedBox(height: 3),
            RadioGroupB(
              grid: 3,
              radioValues: [
                RadioValue(name: "Low", value: 1),
                RadioValue(name: "Medium", value: 2),
                RadioValue(name: "Urgent", value: 3),
              ],
              index: (index) {},
            ),
            const SizedBox(height: 20),
            TextFieldB(
                fieldTitle: "Order Note",
                hintText: "Please write your issue note",
                maxLines: 4,
                controller: state.noteController,
                focusNode: state.noteFocusNode,
                onChanged: (value) {}),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
