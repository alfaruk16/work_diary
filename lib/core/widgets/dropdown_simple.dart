import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'widgets.dart';

class DropdownSimpleB extends StatefulWidget {
  const DropdownSimpleB(
      {Key? key,
      this.dropdownHeight = 48,
      this.icon = Icons.keyboard_arrow_down,
      required this.items,
      required this.selected,
      this.setState = false,
      this.errorText = '',
      this.borderColor = bExtraLightGray,
      this.bgColor = bWhite,
      this.label = '',
      this.isMandatory = false,
      this.dropDownValue,
      this.hint = 'Select'})
      : super(key: key);

  final double? dropdownHeight;
  final IconData? icon;
  final List<DropdownItem> items;
  final Function selected;
  final bool setState;
  final String errorText;
  final Color borderColor, bgColor;
  final String label;
  final bool isMandatory;
  final int? dropDownValue;
  final String hint;

  @override
  State<DropdownSimpleB> createState() => _DropdownFieldBState();
}

class _DropdownFieldBState extends State<DropdownSimpleB> {
  int? dropDownValue;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.setState) {
        dropDownValue = null;
      } else if (widget.dropDownValue != null) {
        dropDownValue = widget.dropDownValue!;
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              alignment: Alignment.centerRight,
              isExpanded: true,
              focusColor: Colors.amber,
              hint: Container(
                  alignment: Alignment.centerLeft,
                  child: TextB(text: widget.hint)),
              icon: Icon(
                widget.icon,
                color: bGray,
              ),
              value: dropDownValue,
              items: widget.items.map((DropdownItem items) {
                return DropdownMenuItem(
                  value: items.value,
                  child: TextB(
                    text: items.name,
                    textStyle: bBody2,
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  widget.selected(val);
                  dropDownValue = val as int;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
