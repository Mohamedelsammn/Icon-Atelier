import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../injection_container.dart';
import '../../settings/presentation/bloc/settings_bloc.dart';
import '../../../../core/routing/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _lottieController;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Lottie animation: 300 frames at 60fps = 5s total, we use ~3s then navigate
    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _lottieController.repeat(reverse: true);

    // Navigate after 3 seconds (frame ~180 / 300)
    Timer(const Duration(seconds: 3), () {
      if (!_hasNavigated && mounted) {
        _hasNavigated = true;
        _checkAndShowPermissionDialog();
      }
    });
  }

  Future<void> _checkAndShowPermissionDialog() async {
    final prefs = sl<SharedPreferences>();
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
    final isDarkMode = context.read<SettingsBloc>().state.isDarkMode;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
                    color: isDarkMode
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
                  t.allowPermission,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : const Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  t.permissionDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
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
                      Navigator.pop(dialogContext);
                      final prefs = sl<SharedPreferences>();
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
                      t.allow,
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
                    final prefs = sl<SharedPreferences>();
                    await prefs.setBool('has_permission_shown', true);
                    SystemNavigator.pop();
                  },
                  child: Text(
                    t.exit,
                    style: TextStyle(
                      color: isDarkMode
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
    Navigator.pushReplacementNamed(context, RouteNames.home);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E184C), Color(0xFF2F2377), Color(0xFF15103C)],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/images/splash_animation_1.json',
            controller: _lottieController,
            fit: BoxFit.contain,
            reverse: true,
            repeat: true,
          ),
        ),
      ),
    );
  }
}
