import 'package:flutter/material.dart';

class AppColor {
  static Color errorColor = const Color.fromARGB(255, 207, 35, 23);
  static Color successColor = const Color.fromARGB(255, 27, 163, 32);

  // Light theme colors
  static Color whiteColor = Colors.white;
  static Color blackColor = const Color(0xFF1f2236); // Dark color for text and icons
  static Color greyColor = const Color(0xFFB0B0B0); // Neutral grey for secondary text
  static Color orangeAccentColor = const Color(0xFFd78521); // Vibrant orange accent
  static Color mainColor = const Color(0xFFD67A09); // Main theme color, slightly adjusted for vibrancy
  static Color textColor = const Color(0xFF4A4A4A); // Light mode secondary text color
  static Color titleColor = const Color(0xFF1A1A1A); // Darker grey for titles and headings

  // Dark theme colors
  static Color darkBackgroundColor = const Color(0xFF121212); // Background color for dark mode
  static Color darkCardColor = const Color(0xFF1E1E1E); // Card background color
  static Color darkTextColor = const Color(0xFFE0E0E0); // Light grey for less harsh text on dark background
  static Color darkTitleColor = Colors.white; // Bright white for titles
}
