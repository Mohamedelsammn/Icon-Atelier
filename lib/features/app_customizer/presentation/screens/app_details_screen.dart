import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/app_entity.dart';
import '../bloc/shortcut/shortcut_bloc.dart';
import '../bloc/shortcut/shortcut_event.dart';
import '../bloc/shortcut/shortcut_state.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';

class AppDetailsScreen extends StatelessWidget {
  final AppEntity app;
  const AppDetailsScreen({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ShortcutBloc>(),
      child: _AppDetailsContent(app: app),
    );
  }
}

class _AppDetailsContent extends StatefulWidget {
  final AppEntity app;
  const _AppDetailsContent({required this.app});

  @override
  State<_AppDetailsContent> createState() => _AppDetailsContentState();
}

class _AppDetailsContentState extends State<_AppDetailsContent> {
  Uint8List? _customIcon;
  bool _hasSelectedNewIcon = false;

  @override
  void initState() {
    super.initState();
    _customIcon = widget.app.iconBytes;
  }

  void _applyIcon() {
    if (_customIcon == null) return;
    context.read<ShortcutBloc>().add(
      CreateShortcutEvent(
        package: widget.app.package,
        name: widget.app.name,
        icon: _customIcon!,
      ),
    );
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _customIcon = bytes;
        _hasSelectedNewIcon = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isDarkMode = context.select((SettingsBloc b) => b.state.isDarkMode);

    // Theme-aware colors
    final scaffoldBg = isDarkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF0F2F8);
    final surfaceColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF111827);
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[500];
    final shadowColor = isDarkMode
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.06);

    return BlocListener<ShortcutBloc, ShortcutState>(
      listener: (ctx, state) {
        if (state is ShortcutSuccess) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(t.shortcutCreated),
              backgroundColor: const Color(0xFF4F46E5),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is ShortcutError) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text('${t.creationFailed}: ${state.message}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          backgroundColor: scaffoldBg,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: surfaceColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: isDarkMode ? Colors.white : const Color(0xFF4F46E5),
              ),
            ),
          ),
          title: Text(
            t.iconAtelier,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : const Color(0xFF4F46E5),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.settings);
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(end: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.settings,
                  size: 18,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildAppHero(t, textColor, secondaryTextColor, isDarkMode),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.curatedPacks,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildPackCards(
                            context,
                            t,
                            surfaceColor,
                            textColor,
                            secondaryTextColor,
                            isDarkMode,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            t.customArt,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildGalleryCard(
                            t,
                            surfaceColor,
                            textColor,
                            secondaryTextColor,
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildApplyButton(context, t, scaffoldBg),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHero(
    AppLocalizations t,
    Color textColor,
    Color? secondaryTextColor,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: isDarkMode ? Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDarkMode ? 27 : 28),
              child: _customIcon != null
                  ? Image.memory(_customIcon!, fit: BoxFit.contain)
                  : Container(
                      color: const Color(0xFF4F46E5),
                      child: const Icon(
                        Icons.apps,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            widget.app.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            t.targetApplication,
            style: TextStyle(fontSize: 14, color: secondaryTextColor),
          ),
        ),
      ],
    );
  }

  Widget _buildPackCards(
    BuildContext context,
    AppLocalizations t,
    Color surfaceColor,
    Color textColor,
    Color? secondaryTextColor,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Expanded(
          child: _CarbonPackCard(
            t: t,
            isDarkMode: isDarkMode,
            surfaceColor: surfaceColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            onTap: () async {
              final bytes = await Navigator.pushNamed(
                context,
                RouteNames.carbonPack,
                arguments: widget.app,
              );
              if (bytes != null && bytes is Uint8List && mounted) {
                setState(() {
                  _customIcon = bytes;
                  _hasSelectedNewIcon = true;
                });
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _PrismPackCard(
            t: t,
            isDarkMode: isDarkMode,
            surfaceColor: surfaceColor,
            textColor: textColor,
            secondaryTextColor: secondaryTextColor,
            onTap: () async {
              final bytes = await Navigator.pushNamed(
                context,
                RouteNames.prismPack,
                arguments: widget.app,
              );
              if (bytes != null && bytes is Uint8List && mounted) {
                setState(() {
                  _customIcon = bytes;
                  _hasSelectedNewIcon = true;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryCard(
    AppLocalizations t,
    Color surfaceColor,
    Color textColor,
    Color? secondaryTextColor,
  ) {
    return GestureDetector(
      onTap: _pickFromGallery,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.photo_library_outlined,
                color: Color(0xFF4F46E5),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.uploadFromGallery,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.uploadHint,
                    style: TextStyle(fontSize: 12, color: secondaryTextColor),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xFFD1D5DB),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyButton(
    BuildContext context,
    AppLocalizations t,
    Color scaffoldBg,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(color: scaffoldBg),
      child: BlocBuilder<ShortcutBloc, ShortcutState>(
        builder: (context, state) {
          final isDarkMode = context.select((SettingsBloc b) => b.state.isDarkMode);
          final isLoading = state is ShortcutLoading;
          return SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: (isLoading || !_hasSelectedNewIcon || _customIcon == null) ? null : _applyIcon,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                disabledBackgroundColor: isDarkMode ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
                disabledForegroundColor: isDarkMode ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      t.applyCustomIcon,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────── Pack Cards ────────────────────────────

class _CarbonPackCard extends StatelessWidget {
  final AppLocalizations t;
  final bool isDarkMode;
  final VoidCallback onTap;
  final Color surfaceColor;
  final Color textColor;
  final Color? secondaryTextColor;

  const _CarbonPackCard({
    required this.t,
    required this.isDarkMode,
    required this.onTap,
    required this.surfaceColor,
    required this.textColor,
    this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _MiniIconTile(
                    icon: Iconsax.message_copy,
                    color: Colors.white,
                    bg: isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFF1A1A1A),
                  ),
                  _MiniIconTile(
                    icon: Iconsax.camera_copy,
                    color: Colors.white,
                    bg: isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFF1A1A1A),
                  ),
                  _MiniIconTile(
                    icon: Iconsax.sms_copy,
                    color: Colors.white,
                    bg: isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFF1A1A1A),
                  ),
                  _MiniIconTile(
                    icon: Iconsax.map_copy,
                    color: Colors.white,
                    bg: isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFF1A1A1A),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.carbonPack,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              t.outline,
              style: TextStyle(fontSize: 12, color: secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrismPackCard extends StatelessWidget {
  final AppLocalizations t;
  final bool isDarkMode;
  final VoidCallback onTap;
  final Color surfaceColor;
  final Color textColor;
  final Color? secondaryTextColor;

  const _PrismPackCard({
    required this.t,
    required this.isDarkMode,
    required this.onTap,
    required this.surfaceColor,
    required this.textColor,
    this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const _MiniIconTile(
                    icon: Iconsax.facebook,
                    color: Colors.white,
                    bg: Color.fromARGB(255, 68, 114, 239),
                  ),
                  const _MiniIconTile(
                    icon: Iconsax.instagram,
                    color: Colors.white,
                    bg: Color.fromARGB(255, 226, 93, 93),
                  ),
                  const _MiniIconTile(
                    icon: Icons.discord,
                    color: Colors.white,
                    bg: Color(0xFF06B6D4),
                  ),
                  _MiniIconTile(
                    icon: Icons.tiktok,
                    color: Colors.white,
                    bg: isDarkMode ? const Color(0xFF252525) : const Color.fromARGB(255, 1, 14, 9),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.prismPack,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              t.gradient,
              style: TextStyle(fontSize: 12, color: secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniIconTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bg;
  const _MiniIconTile({
    required this.icon,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 18,
        color: color == Colors.white && bg == const Color(0xFFF3F4F6)
            ? const Color(0xFF9CA3AF)
            : color,
      ),
    );
  }
}
