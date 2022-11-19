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
        color: Colors.transparent,
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

TextStyle get inputSubTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Color(0xFFFFB746) : Colors.grey[900]));
}

TextStyle get inputHintSubTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get inputHintStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Get.isDarkMode ? Colors.red[400] : Colors.red));
}

TextStyle get inputTiitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

TextStyle get tileStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}
