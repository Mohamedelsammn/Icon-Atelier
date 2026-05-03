import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

    // Navigate after 5 seconds (frame ~180 / 300)
    Timer(const Duration(seconds: 5), () {
      if (!_hasNavigated && mounted) {
        _hasNavigated = true;
        _goToHome();
      }
    });
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
