import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/Auth/login/login_screen.dart';
import '../../../modules/Home/home_screen.dart';

void loginUser(context) async {
  // Assuming the login process is successful
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()), // Replace with your home screen widget
  );
}

void logoutUser(context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()), // Replace with your login screen widget
  );
}