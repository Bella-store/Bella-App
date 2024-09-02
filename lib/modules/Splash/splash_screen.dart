import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bella_app/modules/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

import '../../layout_screen.dart'; // Replace with your actual layout screen import
import '../Auth/login/login_screen.dart'; // Replace with your actual login screen import

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedSplashScreen(
      splashIconSize: screenWidth * 0.8,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      pageTransitionType: PageTransitionType.rightToLeft,
      centered: true,
      duration: 1000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: screenWidth * 0.8,
            image: const AssetImage("assets/images/bella_logo.png"),
          ),
        ],
      ),
      nextScreen: FutureBuilder<bool>(
        future: _checkOnboardingStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              // User has seen onboarding, go to login or main layout
              return _navigateToNextScreen(context);
            } else {
              // Show onboarding screen
              return const OnboardingScreen();
            }
          } else {
            // Still loading
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenOnboarding') ?? false;
  }

  Widget _navigateToNextScreen(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data;
          bool isLoggedIn = prefs?.getBool('isLoggedIn') ?? false;
          if (isLoggedIn) {
            return const LayoutScreen(); // Replace with your main layout screen
          } else {
            return const LoginScreen(); // Replace with your login screen
          }
        } else {
          return const CircularProgressIndicator(); // Show a loading indicator while preferences are loading
        }
      },
    );
  }
}
