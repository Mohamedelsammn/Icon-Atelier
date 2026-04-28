import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:iconschange/features/home/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Loading Indicator Widget مدمج في نفس الملف
class LoadingIndicator extends StatelessWidget {
  final int activeIndex;
  final bool isDarkMode;

  const LoadingIndicator({
    super.key,
    required this.activeIndex,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: activeIndex == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == activeIndex
                ? const Color(0xFF4F46E5)
                : (isDarkMode ? Colors.grey[600] : const Color(0xFF745479)),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Function? onSettingsChanged;
  const SplashScreen({super.key, this.onSettingsChanged});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _activeDotIndex = 0;
  late Timer _timer;
  bool _hasNavigated = false;
  bool _isDarkMode = false;
  String _language = 'en';

  @override
  void initState() {
    super.initState();
    _loadSettingsAndStart();
  }

  Future<void> _loadSettingsAndStart() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _isDarkMode = prefs.getBool('isDarkMode') ?? false;
        _language = prefs.getString('language') ?? 'en';
      });
    }
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _activeDotIndex = (_activeDotIndex + 1) % 3;
        });
      }
    });

    Timer(const Duration(seconds: 3), () {
      _timer.cancel();
      if (!_hasNavigated && mounted) {
        _hasNavigated = true;
        _checkAndShowPermissionDialog();
      }
    });
  }

  Future<void> _checkAndShowPermissionDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenPermissionDialog =
        prefs.getBool('has_permission_shown') ?? false;

    if (hasSeenPermissionDialog) {
      _goToHome();
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    final t = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isDarkMode
                        ? const Color(0xFF2C2C2C)
                        : const Color(0xFFF5F5F5),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/Icon Graphic (Intentional Asymmetry & Layering)_margin.svg',
                      width: 50,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _language == 'en' ? 'Allow Permission' : 'السماح بالإذن',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _isDarkMode ? Colors.white : const Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _language == 'en'
                      ? 'To change app icons, we need permission to read your installed apps.'
                      : 'لتغيير أيقونات التطبيقات، نحتاج إلى إذن لقراءة تطبيقاتك المثبتة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: _isDarkMode
                        ? Colors.grey[400]
                        : const Color(0xFF6B6B6B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('has_permission_shown', true);
                      if (mounted) _goToHome();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E45E4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _language == 'en' ? 'Allow' : 'السماح',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('has_permission_shown', true);
                    SystemNavigator.pop();
                  },
                  child: Text(
                    _language == 'en' ? 'Exit' : 'خروج',
                    style: TextStyle(
                      color: _isDarkMode
                          ? Colors.grey[400]
                          : const Color(0xFF999999),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _goToHome() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(onSettingsChanged: widget.onSettingsChanged),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: const [
                            Color.fromARGB(40, 78, 69, 228),
                            Color.fromARGB(40, 245, 205, 249),
                          ],
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/Icon Graphic (Intentional Asymmetry & Layering)_margin.svg',
                          width: 130,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _language == 'en' ? 'Icon Atelier' : 'أيقونة أتلييه',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        letterSpacing: -0.5,
                        color: _isDarkMode
                            ? Colors.white
                            : const Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _language == 'en'
                          ? 'THE DIGITAL CURATOR'
                          : 'المنسق الرقمي',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 1.5,
                        color: _isDarkMode
                            ? Colors.grey[500]
                            : const Color(0xFF8E8E8E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoadingIndicator(
                    activeIndex: _activeDotIndex,
                    isDarkMode: _isDarkMode,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _language == 'en' ? 'CURATING' : 'جاري التجهيز',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      letterSpacing: 1.1,
                      color: _isDarkMode
                          ? Colors.grey[500]
                          : const Color(0xFF5A6062),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
