import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bella_app/modules/Landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedSplashScreen(
      splashIconSize: screenWidth * 0.8,
      splashTransition:
          SplashTransition.fadeTransition, // Fade out splash screen
      backgroundColor: Colors.white,
      pageTransitionType: PageTransitionType.fade, // Fade in next screen
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: screenWidth * 0.8,
            image: const AssetImage("assets/images/bella_logo.png"),
          ),
        ],
      ),
      nextScreen: const LandingScreen(),
    );
  }
}
