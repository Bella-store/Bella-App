import 'package:bella_app/shared/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'Admin/modules/Products/cubit/add_product_cubit.dart';
import 'layout_screen.dart';
import 'modules/Splash/splash_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/stripe_payment/stripe_keys.dart';
import 'shared/local/languages/app_localizations.dart';
import 'modules/Auth/cubit/auth_cubit.dart';
import 'modules/Products/cubit/all_products_cubit.dart';
import 'modules/Favorites/cubit/favorites_cubit.dart';
import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();

  Stripe.publishableKey=ApiKeys.pusblishableKey;
  
  String? localeCode = prefs.getString('locale') ?? 'en';
  bool isDarkMode =
      prefs.getBool('isDarkMode') ?? false; // Default to light mode
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  // Load user model from shared preferences to determine the initial screen
  UserModel? userModel = await UserModel.loadFromPreferences();
  Widget initialScreen;

  if (userModel != null) {
    initialScreen =
        const LayoutScreen(); // User is logged in, show the main layout directly
  } else if (!hasSeenOnboarding) {
    initialScreen =
        const OnboardingScreen(); // User hasn't seen onboarding, show the onboarding screen
  } else {
    initialScreen =
        const SplashScreen(); // User hasn't logged in, show splash screen
  }

  runApp(MyApp(
    locale: Locale(localeCode),
    isDarkMode: isDarkMode,
    initialScreen: initialScreen,
  ));
}

class MyApp extends StatefulWidget {
  final Locale locale;
  final bool isDarkMode;
  final Widget initialScreen;

  const MyApp({
    super.key,
    required this.locale,
    required this.isDarkMode,
    required this.initialScreen,
  });

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
    _setSystemUIOverlayStyle(); // Set the status bar theme when the app starts
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
      _setSystemUIOverlayStyle(); // Update the status bar theme when the theme changes
    });
  }

  void _setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: _isDarkMode ? darkTheme.primaryColor : Colors.white,
        statusBarIconBrightness:
            _isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setSystemUIOverlayStyle(); // Ensure the status bar theme is applied when the widget is rebuilt

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..checkLoggedIn(),
        ),
        BlocProvider<AddProductCubit>(
          create: (context) => AddProductCubit(),
        ),
        BlocProvider<AllProductsCubit>(
          create: (context) => AllProductsCubit()
            ..loadAllProducts(), // Initialize and load all products
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(
            productsCubit: context.read<AllProductsCubit>(),
          ), // Pass AllProductsCubit to FavoritesCubit
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          // Determine the initial screen based on the state
          Widget initialScreen = widget.initialScreen;
          if (state is LogingSuccessState || state is SignUpSuccessState) {
            initialScreen = const LayoutScreen();
          }

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
            home: initialScreen,
          );
        },
      ),
    );
  }
}
