import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final t = AppLocalizations.of(context)!;
          final isDarkMode = state.isDarkMode;

          return Scaffold(
            backgroundColor:
                isDarkMode ? const Color(0xFF121212) : const Color(0xFFF1F3F5),
            body: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(context, isDarkMode, t),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildSectionTitle(t.settings, isDarkMode),
                          const SizedBox(height: 12),
                          _buildSettingCard(
                            isDarkMode: isDarkMode,
                            children: [
                              _buildSwitchTile(
                                icon: Icons.dark_mode_outlined,
                                title: t.darkMode,
                                subtitle: t.darkModeSub,
                                value: isDarkMode,
                                onChanged: (val) {
                                  context.read<SettingsBloc>().add(ToggleTheme(val));
                                },
                                isDarkMode: isDarkMode,
                              ),
                              _buildDivider(isDarkMode),
                              _buildLanguageTile(context, isDarkMode, t, state.languageCode),
                            ],
                          ),
                          const SizedBox(height: 30),
                          _buildSectionTitle(t.about, isDarkMode),
                          const SizedBox(height: 12),
                          _buildSettingCard(
                            isDarkMode: isDarkMode,
                            children: [
                              _buildListTile(
                                icon: Icons.info_outline,
                                title: t.about,
                                subtitle: t.aboutSub,
                                isDarkMode: isDarkMode,
                                onTap: () => _showAboutDialog(context, isDarkMode, t),
                              ),
                              _buildDivider(isDarkMode),
                              _buildListTile(
                                icon: Icons.privacy_tip_outlined,
                                title: t.privacyPolicy,
                                subtitle: t.privacySub,
                                isDarkMode: isDarkMode,
                                onTap: () => _showPrivacyPolicyDialog(context, isDarkMode, t),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDarkMode, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            t.settings,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSettingCard({required bool isDarkMode, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x26ADB3B5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDarkMode,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF4F46E5)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFF4F46E5),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, bool isDarkMode, AppLocalizations t, String currentLang) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.language, color: Color(0xFF4F46E5)),
      ),
      title: Text(
        t.language,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        t.languageSub,
        style: TextStyle(
          fontSize: 12,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langButton(
            context,
            t.english,
            "en",
            currentLang == "en",
            isDarkMode,
          ),
          const SizedBox(width: 8),
          _langButton(
            context,
            t.arabic,
            "ar",
            currentLang == "ar",
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _langButton(BuildContext context, String text, String code, bool isSelected, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.read<SettingsBloc>().add(ChangeLanguage(code));
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4F46E5)
              : (isDarkMode ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDarkMode ? Colors.white70 : Colors.black87),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF4F46E5)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
      ),
    );
  }

  Widget _buildDivider(bool isDarkMode) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFF1F3F5),
      indent: 64,
    );
  }
  void _showAboutDialog(BuildContext context, bool isDarkMode, AppLocalizations t) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.info_outline, color: Color(0xFF4F46E5), size: 28),
                ),
                const SizedBox(width: 16),
                Text(
                  t.about,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.aboutText,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildInfoRow(Icons.verified_outlined, t.version, "1.0.0", isDarkMode),
                    _buildInfoRow(Icons.developer_mode_outlined, t.developer, "Icon Atelier Team", isDarkMode),
                    _buildInfoRow(Icons.update_outlined, t.lastUpdated, "May 2026", isDarkMode),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        t.madeWith,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context, bool isDarkMode, AppLocalizations t) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.security_outlined, color: Color(0xFF10B981), size: 28),
                ),
                const SizedBox(width: 16),
                Text(
                  t.privacyPolicy,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.privacyText1,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPrivacyPoint(t.privacyText2, isDarkMode),
                    _buildPrivacyPoint(t.privacyText3, isDarkMode),
                    _buildPrivacyPoint(t.privacyText4, isDarkMode),
                    _buildPrivacyPoint(t.privacyText5, isDarkMode),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.black26 : Colors.blue.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDarkMode ? Colors.white10 : Colors.blue.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.contact_support_outlined, color: isDarkMode ? Colors.blue[300] : Colors.blue[600]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              t.privacyQuestions,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF4F46E5).withValues(alpha: 0.7)),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPoint(String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
