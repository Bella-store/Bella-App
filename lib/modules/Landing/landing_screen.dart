import 'package:flutter/material.dart';
import '../../shared/app_color.dart';
import '../../shared/app_string.dart';
import '../Auth/login/login_screen.dart';
import '../Auth/signup/signup_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppString.splash,
            ),
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: AppColor.greyColor),
                  minimumSize: const Size(320, 50),
                  // backgroundColor: AppColor.whiteColor,
                  backgroundColor: AppColor.mainColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 19, 3, 3),
                      fontFamily: 'Montserrat'),
                ),
                child: Text(
                  AppString.login(context),
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignUpScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: AppColor.greyColor),
                  minimumSize: const Size(320, 50),
                  backgroundColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 19, 3, 3),
                    fontFamily: 'Montserrat',
                  ),
                ),
                child: Text(
                  AppString.signUp(context),
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
