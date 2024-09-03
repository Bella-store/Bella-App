import 'package:bella_app/shared/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'layout_screen.dart';
import 'modules/Splash/splash_screen.dart';
import 'modules/Products/products_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'shared/local/languages/app_localizations.dart';
import 'modules/Auth/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  String? localeCode = prefs.getString('locale') ?? 'en';
  bool isDarkMode =
      prefs.getBool('isDarkMode') ?? false; // Default to light mode
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  Widget initialScreen = const SplashScreen(); // Default to splash screen

  if (isLoggedIn) {
    // User is logged in, show the main layout directly
    initialScreen = const LayoutScreen();
  } else if (!hasSeenOnboarding) {
    // User hasn't seen onboarding, show the onboarding screen
    initialScreen = const OnboardingScreen();
  } else {
    // User hasn't logged in, show splash screen
    initialScreen = const SplashScreen();
  }

  runApp(MyApp(
      locale: Locale(localeCode),
      isDarkMode: isDarkMode,
      initialScreen: initialScreen));
}

class MyApp extends StatefulWidget {
  final Locale locale;
  final bool isDarkMode;
  final Widget initialScreen;

  const MyApp(
      {super.key,
      required this.locale,
      required this.isDarkMode,
      required this.initialScreen});

  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }

  static void toggleTheme(BuildContext context, bool isDarkMode) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.toggleTheme(isDarkMode);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Locale _locale;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
    _isDarkMode = widget.isDarkMode;
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  void toggleTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Bella App',
            debugShowCheckedModeBanner: false,
            locale: _locale,
            theme: _isDarkMode ? darkTheme : lightTheme,
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: widget.initialScreen,
          );
        },
      ),
    );
  }
}
