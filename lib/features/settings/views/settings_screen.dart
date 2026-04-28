import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setString('language', _selectedLanguage);
  }

  void _toggleDarkMode(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    await _saveSettings();
    // العودة إلى الشاشة الرئيسية مع إشارة بتغيير الإعدادات
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  void _changeLanguage(String lang) async {
    setState(() {
      _selectedLanguage = lang;
    });
    await _saveSettings();

    // العودة إلى الشاشة الرئيسية مع إشارة بتغيير الإعدادات
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF1F3F5),
      appBar: AppBar(
        backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          t.settings,
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: _isDarkMode
              ? Brightness.light
              : Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: Icons.dark_mode,
                    title: t.darkMode,
                    subtitle: t.darkModeSub,
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: _toggleDarkMode,
                      activeColor: const Color(0xFF4F46E5),
                    ),
                    isDarkMode: _isDarkMode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: Icons.language,
                    title: t.language,
                    subtitle: t.languageSub,
                    isDarkMode: _isDarkMode,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLanguageButton(t.english, 'en'),
                        const SizedBox(width: 12),
                        _buildLanguageButton(t.arabic, 'ar'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    icon: Icons.info_outline,
                    title: t.about,
                    subtitle: t.aboutSub,
                    isDarkMode: _isDarkMode,
                    onTap: () => _showAboutDialog(context),
                  ),
                  _buildDivider(_isDarkMode),
                  _buildSettingItem(
                    icon: Icons.privacy_tip_outlined,
                    title: t.privacyPolicy,
                    subtitle: t.privacySub,
                    isDarkMode: _isDarkMode,
                    onTap: () => _showPrivacyDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF2C2C2C)
                    : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF4F46E5), size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
            if (onTap != null && trailing == null)
              Icon(
                Icons.chevron_right,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDarkMode) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      indent: 72,
    );
  }

  Widget _buildLanguageButton(String text, String langCode) {
    final isSelected = _selectedLanguage == langCode;
    return GestureDetector(
      onTap: () => _changeLanguage(langCode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4F46E5)
              : (_isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey[200]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4F46E5) : Colors.transparent,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (_isDarkMode ? Colors.white70 : Colors.black54),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        title: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.info, color: Color(0xFF4F46E5)),
            ),
            const SizedBox(width: 12),
            Text(
              t.appName,
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${t.version}: 1.0.0',
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.aboutText,
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4F46E5),
            ),
            child: Text(t.ok),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        title: Text(
          t.privacyPolicy,
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.privacyText1,
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.privacyText2,
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            Text(
              t.privacyText3,
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4F46E5),
            ),
            child: Text(t.ok),
          ),
        ],
      ),
    );
  }
}
