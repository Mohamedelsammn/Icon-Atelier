import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/icon_converter.dart';
import '../bloc/icon_pack/icon_pack_bloc.dart';
import '../bloc/icon_pack/icon_pack_event.dart';
import '../bloc/icon_pack/icon_pack_state.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';

class CarbonPackScreen extends StatelessWidget {
  const CarbonPackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IconPackBloc()..add(const LoadIconPackEvent('carbon')),
      child: const _CarbonPackContent(),
    );
  }
}

class _CarbonPackContent extends StatefulWidget {
  const _CarbonPackContent();

  @override
  State<_CarbonPackContent> createState() => _CarbonPackContentState();
}

class _CarbonPackContentState extends State<_CarbonPackContent> {
  int? _selectedIndex;
  bool _isApplying = false;

  Future<void> _applyPack(
    BuildContext context,
    List<IconItem> icons,
    String style,
  ) async {
    if (_selectedIndex == null) {
      // If none selected, use first icon
      final idx = 0;
      setState(() => _isApplying = true);
      final icon = icons[idx];
      final isOutline = style == 'outline';
      final bytes = await IconConverter.iconToBytes(
        isOutline ? icon.outlineIcon : icon.solidIcon,
        backgroundColor: isOutline ? const Color(0xFF1A1A1A) : Colors.white,
        color: isOutline ? Colors.white : const Color(0xFF1A1A1A),
        isOutline: isOutline,
      );
      setState(() => _isApplying = false);
      if (context.mounted) Navigator.pop(context, bytes);
      return;
    }
    setState(() => _isApplying = true);
    final icon = icons[_selectedIndex!];
    final isOutline = style == 'outline';
    final bytes = await IconConverter.iconToBytes(
      isOutline ? icon.outlineIcon : icon.solidIcon,
      backgroundColor: isOutline ? const Color(0xFF1A1A1A) : Colors.white,
      color: isOutline ? Colors.white : const Color(0xFF1A1A1A),
      isOutline: isOutline,
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
          t.carbonPack,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<IconPackBloc, IconPackState>(
        builder: (context, state) {
          if (state is IconPackLoading || state is IconPackInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
            );
          }
          if (state is! IconPackLoaded) return const SizedBox();
          final icons = state.filteredIcons;
          final style = state.selectedStyle;

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildHeroCard(t, style, context),
                    ),
                    SliverToBoxAdapter(
                      child: _buildStyleToggle(style, context, surfaceColor, isDarkMode, t),
                    ),
                    SliverToBoxAdapter(
                      child: _buildIconsHeader(icons.length, t, textColor, isDarkMode),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => _buildIconTile(ctx, icons[i], i, style),
                          childCount: icons.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.85,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildApplyButton(context, icons, style, t, scaffoldBg),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(
    AppLocalizations t,
    String style,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Badge
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6EE7B7),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    t.premiumTheme,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Text
          Positioned(
            bottom: 20,
            left: 20,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.carbonPackTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.carbonPackDesc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          // 3D icon preview
          Positioned(right: 10, bottom: 10, child: _buildHeroIconStack()),
        ],
      ),
    );
  }

  Widget _buildHeroIconStack() {
    return SizedBox(
      width: 90,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back card
          Positioned(
            top: 0,
            right: 0,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Front card
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(
                Iconsax.sms,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleToggle(String style, BuildContext context, Color surfaceColor, bool isDarkMode, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            _ToggleTab(
              label: t.outline,
              selected: style == 'outline',
              isDarkMode: isDarkMode,
              onTap: () => context.read<IconPackBloc>().add(
                const ToggleStyleEvent('outline'),
              ),
            ),
            _ToggleTab(
              label: t.solid,
              selected: style == 'solid',
              isDarkMode: isDarkMode,
              onTap: () => context.read<IconPackBloc>().add(
                const ToggleStyleEvent('solid'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconsHeader(int count, AppLocalizations t, Color textColor, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t.includedIcons,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE8E8F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count ${t.total}',
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.white70 : const Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconTile(
    BuildContext context,
    IconItem item,
    int index,
    String style,
  ) {
    final selected = _selectedIndex == index;
    final isOutline = style == 'outline';
    
    // Conditional colors based on style
    final containerColor = isOutline ? const Color(0xFF1A1A1A) : Colors.white;
    final contentColor = isOutline ? Colors.white : const Color(0xFF1A1A1A);
    final iconOpacity = isOutline ? 0.85 : 1.0;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = selected ? null : index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF4F46E5) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: selected ? 0.15 : 0.08),
              blurRadius: selected ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              style == 'outline' ? item.outlineIcon : item.solidIcon,
              size: 30,
              color: contentColor.withValues(alpha: iconOpacity),
            ),
            const SizedBox(height: 8),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 11,
                color: contentColor.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyButton(
    BuildContext context,
    List<IconItem> icons,
    String style,
    AppLocalizations t,
    Color scaffoldBg,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(color: scaffoldBg),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: _isApplying
              ? null
              : () => _applyPack(context, icons, style),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          icon: _isApplying
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
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

// ──────────────────────────── Toggle Tab ────────────────────────────
class _ToggleTab extends StatelessWidget {
  final String label;
  final bool selected;
  final bool isDarkMode;
  final VoidCallback onTap;
  const _ToggleTab({
    required this.label,
    required this.selected,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF4F46E5) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : (isDarkMode ? Colors.white70 : const Color(0xFF6B7280)),
            ),
          ),
        ),
      ),
    );
  }
}
