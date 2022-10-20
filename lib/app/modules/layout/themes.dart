import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: white,
      appBarTheme: const AppBarTheme(
        color: white,
      ));

  static final dark = ThemeData(
      primaryColor: darkGrayClr,
      brightness: Brightness.dark,
      backgroundColor: darkGrayClr,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
      ));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}
