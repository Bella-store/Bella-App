import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required ContentType contentType,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Color backgroundColor = Colors.transparent,
    double elevation = 0,
  }) {
    final snackBar = SnackBar(
      elevation: elevation,
      behavior: behavior,
      backgroundColor: backgroundColor,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
