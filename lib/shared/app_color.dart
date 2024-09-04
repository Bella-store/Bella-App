import 'package:flutter/material.dart';

class AppColor {
  static Color errorColor = const Color.fromARGB(255, 207, 35, 23);
  static Color successColor = const Color.fromARGB(255, 27, 163, 32);

  // Light theme colors
  static Color whiteColor = Colors.white;
  static Color blackColor =
      const Color(0xFF1f2236); // Dark color for text and icons
  static Color greyColor =
      const Color(0xFFB0B0B0); // Neutral grey for secondary text
  static Color orangeAccentColor =
      const Color(0xFFd78521); // Vibrant orange accent
  static Color mainColor = const Color(
      0xFFB48E61); // Main theme color, slightly adjusted for vibrancy
  static Color textColor =
      const Color(0xFF4A4A4A); // Light mode secondary text color
  static Color titleColor =
      const Color(0xFF1A1A1A); // Darker grey for titles and headings

  // Updated Dark theme colors
  static Color darkBackgroundColor =
      const Color(0xff242424); // New background color
  static Color darkCardColor =
      const Color(0xff3C3D37); // New card and secondary color
  static Color darkTextColor =
      const Color(0xffD7CCBC); // New text color for dark mode
  static Color darkTitleColor = const Color(0xffD7CCBC); // New color for titles
  static Color darkAccentColor =
      const Color(0xffB48E61); // Accent color for buttons, links, etc.
}
