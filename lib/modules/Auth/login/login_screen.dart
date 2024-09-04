import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cubit/auth_cubit.dart';
import '../signup/signup_screen.dart';

import '../../../layout_screen.dart'; // Replace with your main layout screen import
import '../../../shared/app_color.dart';
import '../../../shared/app_string.dart';
import '../../../shared/custom_snackbar.dart'; // Import the CustomSnackbar

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is LogingSuccessState) {
            // Navigate to the main layout screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LayoutScreen(),
              ),
            );

            // Show success message using CustomSnackbar
            CustomSnackbar.show(
              context,
              title: 'Success!',
              message: 'Login successful!',
              contentType: ContentType.success,
            );
          } else if (state is LogingErrorState) {
            // Show error message using CustomSnackbar
            CustomSnackbar.show(
              context,
              title: 'Error',
              message: state.error,
              contentType: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            endIndent: 10.0,
                          ),
                        ),
                        SvgPicture.asset(
                          AppString.group,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            indent: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    AppString.welcome(context),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    AppString.plzLogin(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: AppString.email(context),
                            suffixIcon: emailController.text.contains('@gmail.com')
                                ? const Icon(Icons.check, color: Colors.green)
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppString.plzEnterEmail(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: AppString.password(context),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppString.plzEnterPassword(context);
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              BlocProvider.of<AuthCubit>(context).login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(320, 50),
                            backgroundColor: AppColor.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Text(
                            AppString.login(context),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.dontHaveAnAccount(context),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppString.signUp(context),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
