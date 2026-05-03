import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/icon_converter.dart';
import '../bloc/icon_pack/icon_pack_bloc.dart';
import '../bloc/icon_pack/icon_pack_event.dart';
import '../bloc/icon_pack/icon_pack_state.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';

class PrismPackScreen extends StatelessWidget {
  const PrismPackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IconPackBloc()..add(const LoadIconPackEvent('prism')),
      child: const _PrismPackContent(),
    );
  }
}

class _PrismPackContent extends StatefulWidget {
  const _PrismPackContent();

  @override
  State<_PrismPackContent> createState() => _PrismPackContentState();
}

class _PrismPackContentState extends State<_PrismPackContent> {
  int? _selectedIndex;
  bool _isApplying = false;

  // Prism icon colors — each icon gets a distinct pastel background
  static const List<Color> _bgColors = [
    Color(0xFFEDE9FE), // light purple
    Color(0xFFD1FAE5), // light green
    Color(0xFFFEE2E2), // light red
    Color(0xFFE0F2FE), // light blue
    Color(0xFFFEF3C7), // light yellow
    Color(0xFFF3E8FF), // light violet
    Color(0xFFFFE4E6), // light pink
    Color(0xFFCCFBF1), // light teal
  ];

  static const List<Color> _iconColors = [
    Color(0xFF7C3AED), // purple
    Color(0xFF059669), // green
    Color(0xFFDC2626), // red
    Color(0xFF0284C7), // blue
    Color(0xFFD97706), // amber
    Color(0xFF9333EA), // violet
    Color(0xFFE11D48), // rose
    Color(0xFF0D9488), // teal
  ];

  Color _getBg(IconItem item, int index) {
    if (item.category == 'social') {
      switch (item.name.toLowerCase()) {
        case 'facebook': return const Color(0xFFE7F0FD);
        case 'instagram': return const Color(0xFFFCE7F0);
        case 'youtube': return const Color(0xFFFCE7E7);
        case 'tiktok': return const Color(0xFFEAEAEA);
        case 'twitter': return const Color(0xFFE7EEFC);
        case 'discord': return const Color(0xFFEBE7FC);
        case 'telegram': return const Color(0xFFE7F3FC);
        case 'whatsapp': return const Color(0xFFE7FCEE);
        case 'snapchat': return const Color(0xFFFCFBE7);
      }
    }
    return _bgColors[index % _bgColors.length];
  }

  Color _getIconColor(IconItem item, int index) {
    if (item.category == 'social') {
      switch (item.name.toLowerCase()) {
        case 'facebook': return const Color(0xFF1877F2);
        case 'instagram': return const Color(0xFFE4405F);
        case 'youtube': return const Color(0xFFFF0000);
        case 'tiktok': return const Color(0xFF000000);
        case 'twitter': return const Color(0xFF1DA1F2);
        case 'discord': return const Color(0xFF5865F2);
        case 'telegram': return const Color(0xFF0088CC);
        case 'whatsapp': return const Color(0xFF25D366);
        case 'snapchat': return const Color(0xFFD4B100);
      }
    }
    return _iconColors[index % _iconColors.length];
  }

  Future<void> _applyPack(BuildContext context, List<IconItem> icons) async {
    final idx = _selectedIndex ?? 0;
    setState(() => _isApplying = true);
    final icon = icons[idx];
    final bytes = await IconConverter.iconToBytes(
      icon.solidIcon,
      backgroundColor: _getBg(icon, idx),
      color: _getIconColor(icon, idx),
      isPrism: true,
    );
    setState(() => _isApplying = false);
    if (context.mounted) Navigator.pop(context, bytes);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isDarkMode = context.select((SettingsBloc b) => b.state.isDarkMode);
    
    final scaffoldBg = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF0F2F8);
    final surfaceColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF111827);
    final shadowColor = isDarkMode ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.06);

    return Scaffold(
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
              boxShadow: [BoxShadow(color: shadowColor, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 16, color: isDarkMode ? Colors.white : const Color(0xFF4F46E5)),
          ),
        ),
        title: Text(t.prismPack,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : const Color(0xFF111827))),
        centerTitle: true,
      ),
      body: BlocBuilder<IconPackBloc, IconPackState>(
        builder: (context, state) {
          if (state is IconPackLoading || state is IconPackInitial) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF4F46E5)));
          }
          if (state is! IconPackLoaded) return const SizedBox();


          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildHeroCard(t, isDarkMode),
                    ),
                    SliverToBoxAdapter(
                      child: _buildCategoryTabs(state.selectedCategory, context, surfaceColor, isDarkMode, t),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => _buildIconTile(ctx, state.filteredIcons[i], i, surfaceColor, textColor),
                          childCount: state.filteredIcons.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildApplyButton(context, state.filteredIcons, t, scaffoldBg),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(AppLocalizations t, bool isDarkMode) {
    final heroBg = isDarkMode ? const Color(0xFF2D2A4A) : const Color(0xFFEDE9FE);
    final heroTitleColor = isDarkMode ? Colors.white : const Color(0xFF1F1035);
    final heroDescColor = isDarkMode ? Colors.white70 : const Color(0xFF1F1035).withValues(alpha: 0.6);

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: heroBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Premium badge
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black26 : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_outlined, size: 14, color: Color(0xFF7C3AED)),
                  const SizedBox(width: 4),
                  Text(t.premiumTheme,
                      style: const TextStyle(
                          color: Color(0xFF7C3AED), fontSize: 11, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Hero icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withValues(alpha: 0.1) : Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: 0.15), blurRadius: 16, offset: const Offset(0, 6)),
              ],
            ),
            child: Icon(Iconsax.star, color: Color(0xFF7C3AED), size: 38),
          ),
          const SizedBox(height: 16),
          Text(
            t.prismModernTitle,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: heroTitleColor),
          ),
          const SizedBox(height: 8),
          Text(
            t.prismModernDesc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: heroDescColor, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(String selected, BuildContext context, Color surfaceColor, bool isDarkMode, AppLocalizations t) {
    final tabs = [
      ('all', t.allIcons),
      ('system', t.system),
      ('social', t.social),
      ('productivity', t.productivity),
    ];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final (key, label) = tabs[i];
          final isSelected = selected == key;
          return GestureDetector(
            onTap: () => context.read<IconPackBloc>().add(FilterIconPackEvent(key)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4F46E5) : surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF4F46E5) : (isDarkMode ? Colors.white10 : const Color(0xFFE5E7EB)),
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: const Color(0xFF4F46E5).withValues(alpha: 0.3), blurRadius: 8)]
                    : [],
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : (isDarkMode ? Colors.white70 : const Color(0xFF6B7280)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconTile(BuildContext context, IconItem item, int index, Color surfaceColor, Color textColor) {
    final selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = selected ? null : index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF4F46E5) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: selected ? 0.1 : 0.04),
              blurRadius: selected ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getBg(item, index),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(item.solidIcon, size: 26, color: _getIconColor(item, index)),
            ),
            const SizedBox(height: 8),
            Text(
              item.name,
              style: TextStyle(fontSize: 11, color: textColor.withValues(alpha: 0.6), fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context, List<IconItem> icons, AppLocalizations t, Color scaffoldBg) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(color: scaffoldBg),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: _isApplying ? null : () => _applyPack(context, icons),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          ),
          icon: _isApplying
              ? const SizedBox(
                  width: 18, height: 18,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Icon(Icons.download_outlined, size: 20),
          label: Text(
            _isApplying ? t.applying : t.applyIconPack,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
