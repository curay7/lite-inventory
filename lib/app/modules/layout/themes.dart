import 'package:flutter/material.dart';

const Color bluish = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff5667);
const Color white = Colors.white;
const primaryClr = bluish;
const darkGrayClr = Color(0xFF121212);
const grayClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: primaryClr,
      ));

  static final dark = ThemeData(
      primaryColor: darkGrayClr,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: darkGrayClr,
      ));
}
