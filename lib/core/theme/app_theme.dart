import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      useMaterial3: true,
    );
  }
}
