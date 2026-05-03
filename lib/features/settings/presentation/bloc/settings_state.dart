import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final String languageCode;
  final ThemeMode themeMode;
  final Locale locale;

  SettingsState({
    required this.isDarkMode,
    required this.languageCode,
  })  : themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light,
        locale = Locale(languageCode);

  SettingsState copyWith({
    bool? isDarkMode,
    String? languageCode,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object> get props => [isDarkMode, languageCode, themeMode, locale];
}
