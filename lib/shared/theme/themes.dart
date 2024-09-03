import 'package:flutter/material.dart';
import '../app_color.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.whiteColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.whiteColor,
    iconTheme: IconThemeData(color: AppColor.blackColor),
  ),
  cardColor: AppColor.whiteColor,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColor.textColor),
    bodyMedium: TextStyle(color: AppColor.textColor),
    displayLarge: TextStyle(color: AppColor.titleColor),
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: AppColor.darkAccentColor, // Accent color
    secondary: AppColor.darkCardColor, // Secondary color
    surface: AppColor.darkBackgroundColor, // Background color used for surfaces
    onPrimary: AppColor.darkTextColor, // Text color on primary elements
    onSecondary: AppColor.darkTextColor, // Text color on secondary elements
    onSurface: AppColor.darkTextColor, // Text color on surface
    error: AppColor.errorColor, // Error color
    onError: AppColor.darkTextColor, // Text color on error elements
    brightness: Brightness.dark, // Dark theme brightness
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.darkBackgroundColor, // Background color
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.darkCardColor, // Secondary color for AppBar
    iconTheme: IconThemeData(color: AppColor.darkTextColor), // Icon color
  ),
  cardColor: AppColor.darkCardColor, // Card color for dark mode
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColor.darkTextColor), // Text color
    bodyMedium: TextStyle(color: AppColor.darkTextColor), // Text color
    displayLarge: TextStyle(color: AppColor.darkTitleColor), // Title text color
  ),
);
