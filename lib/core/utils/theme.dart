import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    labelStyle: const TextStyle(color: bGray),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: bLightGray),
      borderRadius: BorderRadius.circular(7),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: bLightGray),
      borderRadius: BorderRadius.circular(7),
    ),
    hintStyle: bBody2,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: bGray),
  );
}
