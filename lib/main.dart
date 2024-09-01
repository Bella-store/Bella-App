import 'package:bella_app/shared/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'modules/Splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'shared/local/languages/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? localeCode = prefs.getString('locale') ?? 'en';
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to light mode

  runApp(MyApp(locale: Locale(localeCode), isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final Locale locale;
  final bool isDarkMode;

  const MyApp({super.key, required this.locale, required this.isDarkMode});

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
      home: const SplashScreen(),
    );
  }
}
