import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';

class SwitchView extends StatefulWidget {
  const SwitchView({super.key, required this.onChanged});
  final Function onChanged;

  @override
  State<SwitchView> createState() => _SwitchViewState();
}

class _SwitchViewState extends State<SwitchView> {
  bool value = true;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      child: FittedBox(
        child: CupertinoSwitch(
          value: value,
          activeColor: bGreen,
          onChanged: (bool val) {
            setState(() {
              value = val;
            });
            widget.onChanged(val);
          },
        ),
      ),
    );
  }
}
