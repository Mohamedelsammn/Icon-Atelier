import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getIsDarkMode();
  Future<void> setIsDarkMode(bool isDark);
  Future<String> getLanguage();
  Future<void> setLanguage(String langCode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getIsDarkMode() async {
    return sharedPreferences.getBool('isDarkMode') ?? false;
  }

  @override
  Future<void> setIsDarkMode(bool isDark) async {
    await sharedPreferences.setBool('isDarkMode', isDark);
  }

  @override
  Future<String> getLanguage() async {
    return sharedPreferences.getString('language') ?? 'en';
  }

  @override
  Future<void> setLanguage(String langCode) async {
    await sharedPreferences.setString('language', langCode);
  }
}
