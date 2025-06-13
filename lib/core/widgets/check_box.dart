import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class CheckboxB extends StatefulWidget {
  const CheckboxB(
      {super.key,
      this.setState = false,
      required this.label,
      required this.press,
      required this.defaultValue});
  final String label;
  final Function press;
  final bool defaultValue;
  final bool setState;

  @override
  State<CheckboxB> createState() => _CheckboxBState();
}

class _CheckboxBState extends State<CheckboxB> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    //Before setstate do flase value in state copyWith function

    setState(() {
      if (widget.setState) {
        _isChecked = false;
      } else {
        _isChecked = widget.defaultValue;
      }
    });

    return Row(
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: bLightGray),
            child: Checkbox(
              splashRadius: 0,
              activeColor: bBlue,
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue!;
                });
                widget.press(_isChecked);
              },
            ),
          ),
        ),
        const SizedBox(width: 7),
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
            widget.press(_isChecked);
          },
          child: TextB(
            text: widget.label,
            fontSize: 16,
            fontColor: bDark,
          ),
        )
      ],
    );
  }
}
