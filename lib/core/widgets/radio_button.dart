import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/utils.dart';
import 'widgets.dart';

class RadioGroupB extends StatefulWidget {
  const RadioGroupB(
      {Key? key,
      required this.radioValues,
      this.grid = 1,
      required this.index,
      this.reset = false})
      : super(key: key);

  final List<RadioValue> radioValues;
  final int? grid;
  final Function index;
  final bool reset;

  @override
  State<RadioGroupB> createState() => _RadioBState();
}

class _RadioBState extends State<RadioGroupB> {
  int _groupValue = 0;

  void setSelected(int val) {
    setState(() {
      _groupValue = val;
      widget.index(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reset) {
      setState(() {
        _groupValue = 0;
      });
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        children: List.generate(
          widget.radioValues.length,
          (index) => FractionallySizedBox(
            widthFactor: 1 / widget.grid!,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Radio(
                      activeColor: bGreen,
                      value: widget.radioValues[index].value,
                      groupValue: _groupValue,
                      onChanged: (int? val) {
                        setSelected(val!);
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setSelected(widget.radioValues[index].value);
                    },
                    child: TextB(
                      text: widget.radioValues[index].name,
                      fontColor: bDarkGray,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadioValue {
  final String name;
  final int value;
  RadioValue({required this.name, required this.value});
}
