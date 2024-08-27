import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bella_app/modules/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
      nextScreen: const OnboardingScreen(),
    );
  }
}
