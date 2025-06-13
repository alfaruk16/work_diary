import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/presentation/activities/create_order_note/bloc/bloc.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class NewOrderItem extends StatelessWidget {
  const NewOrderItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderNoteBloc, CreateOrderNoteState>(
        builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0XFFF0F4F9),
          border: Border.all(color: const Color(0XFFD7D7D8)),
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 8,
              color: const Color(0XFFA6A6A6).withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 145,
                  child: TextB(text: "Brand"),
                ),
                Expanded(
                  child: DropdownSearchB(
                    items: const [DropdownItem(name: 'Select', value: -1)],
                    selected: (index) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 145,
                  child: TextB(text: "Product Type"),
                ),
                Expanded(
                  child: DropdownSearchB(
                    selected: (index) {},
                    items: const [DropdownItem(name: 'Select', value: -1)],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 145,
                  child: TextB(text: "Product Size"),
                ),
                Expanded(
                  child: DropdownSearchB(
                    items: const [DropdownItem(name: 'Select', value: -1)],
                    selected: (index) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 145,
                  child: TextB(text: "Quantity Box"),
                ),
                Expanded(
                  child: TextFieldB(
                      controller: state.qtyController,
                      focusNode: state.qtyFocusNode,
                      hintText: "Ex: 30",
                      onChanged: (value) {}),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
