import 'package:flutter/material.dart';
import 'package:onfly_design_system/src/tokens/onfly_colors.dart';

class OnflyTheme {
  static ThemeData light = ThemeData(
    primaryColor: OnflyColors.primary,
    scaffoldBackgroundColor: OnflyColors.background,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    ),
  );
}
