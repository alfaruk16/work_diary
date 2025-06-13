import 'package:flutter/material.dart';

Future datePicker(BuildContext context,
    {required Function date, DateTime? minDate}) {
  return showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          firstDate: minDate ??
              DateTime.now().subtract(const Duration(days: 365 * 50 + 50 ~/ 4)),
          initialDate: minDate != null &&
                  minDate.millisecondsSinceEpoch >
                      DateTime.now().millisecondsSinceEpoch
              ? minDate
              : DateTime.now(),
          lastDate:
              DateTime.now().add(const Duration(days: 365 * 50 + 50 ~/ 4)))
      .then((time) {
    if (time != null) {
      date(time);
    }
  });
}
