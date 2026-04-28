import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:iconschange/features/splash/views/splash_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  String _language = 'en';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _language = prefs.getString('language') ?? 'en';
    });
  }

  // دالة لإعادة تشغيل التطبيق بالكامل
  void restartApp() {
    // حفظ الإعدادات الحالية
    _loadSettings();
    // إعادة تشغيل التطبيق بالكامل
    runApp(MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icon Atelier',
      locale: Locale(_language),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(onSettingsChanged: restartApp),
      debugShowCheckedModeBanner: false,
    );
  }
}
