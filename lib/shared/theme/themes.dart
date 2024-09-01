import 'package:flutter/material.dart';
import '../app_color.dart';

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
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.darkBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.darkCardColor,
    iconTheme: IconThemeData(color: AppColor.whiteColor),
  ),
  cardColor: AppColor.darkCardColor,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColor.darkTextColor),
    bodyMedium: TextStyle(color: AppColor.darkTextColor),
    displayLarge: TextStyle(color: AppColor.darkTitleColor),
  ),
);
