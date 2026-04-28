import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:iconschange/features/home/presentation/models/app_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrismPackScreen extends StatefulWidget {
  final AppInfo? app;
  const PrismPackScreen({super.key, this.app});

  @override
  State<PrismPackScreen> createState() => _PrismPackScreenState();
}

class _PrismPackScreenState extends State<PrismPackScreen> {
  String selectedStyle = "gradient";
  static const platform = MethodChannel('apps_channel');
  bool _isDarkMode = false;
  String _language = 'en';

  final List<IconData> icons = [
    Icons.mail,
    Icons.camera_alt,
    Icons.message,
    Icons.map,
    Icons.phone,
    Icons.settings,
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.favorite,
    Icons.person,
    Icons.shopping_cart,
    Icons.star,
    Icons.share,
    Icons.delete,
    Icons.edit,
  ];

  final List<String> iconNames = [
    "Mail",
    "Camera",
    "Message",
    "Map",
    "Phone",
    "Settings",
    "Home",
    "Search",
    "Notifications",
    "Favorite",
    "Profile",
    "Cart",
    "Star",
    "Share",
    "Delete",
    "Edit",
  ];

  final List<List<Color>> prismColors = [
    [Color(0xFFF093FB), Color(0xFFF5576C)],
    [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    [Color(0xFF43E97B), Color(0xFF38F9D7)],
    [Color(0xFFFA709A), Color(0xFFFEE140)],
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    [Color(0xFFFF8C00), Color(0xFFF7B733)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],
    [Color(0xFFCB356B), Color(0xFFBD3F32)],
    [Color(0xFF4568DC), Color(0xFFB06AB3)],
    [Color(0xFFEB3349), Color(0xFFF45C43)],
    [Color(0xFF00B4DB), Color(0xFF0083B0)],
    [Color(0xFFF7971E), Color(0xFFFFD200)],
    [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    [Color(0xFFFC466B), Color(0xFF3F5EFB)],
    [Color(0xFF232526), Color(0xFF414345)],
    [Color(0xFF00C9FF), Color(0xFF92FE9D)],
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _language = prefs.getString('language') ?? 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF1F4F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ===== APP BAR =====
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      t.prismPack,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    if (widget.app != null)
                      GestureDetector(
                        onTap: () => _applyToCurrentApp(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            t.apply,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              /// ===== HERO CONTAINER =====
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                      Color(0xFFF093FB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.premiumTheme,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.prismPackTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.prismPackDesc,
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/prism_preview.svg",
                        height: 180,
                        fit: BoxFit.contain,
                        placeholderBuilder: (context) => Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ===== SWITCH =====
              Container(
                width: 280,
                height: 52,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _isDarkMode
                      ? const Color(0xFF2C2C2C)
                      : const Color(0xFFF1F4F5),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    _switchItem(
                      t.gradient,
                      selectedStyle == "gradient",
                      () => setState(() => selectedStyle = "gradient"),
                    ),
                    _switchItem(
                      t.solid,
                      selectedStyle == "solid",
                      () => setState(() => selectedStyle = "solid"),
                    ),
                    _switchItem(
                      t.outline,
                      selectedStyle == "outline",
                      () => setState(() => selectedStyle = "outline"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ===== HEADER =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      t.includedIcons,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _isDarkMode
                            ? const Color(0xFF2C2C2C)
                            : const Color(0xFFF1F4F5),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        "${icons.length} ${t.total}",
                        style: TextStyle(
                          color: _isDarkMode
                              ? Colors.white70
                              : const Color(0xFF5A6062),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ===== GRID =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: icons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) => _iconItem(
                    icons[index],
                    iconNames[index],
                    prismColors[index % prismColors.length],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _switchItem(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  )
                : null,
            color: active ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                color: active
                    ? Colors.white
                    : (_isDarkMode ? Colors.white70 : const Color(0xFF5A6062)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconItem(IconData icon, String name, List<Color> colors) {
    return GestureDetector(
      onTap: () => widget.app != null
          ? _showPreviewAndApply(context, icon, name, colors)
          : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: selectedStyle == "gradient"
                    ? LinearGradient(
                        colors: colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: selectedStyle == "solid"
                    ? colors.first
                    : selectedStyle == "outline"
                    ? Colors.transparent
                    : null,
                borderRadius: BorderRadius.circular(16),
                border: selectedStyle == "outline"
                    ? Border.all(color: colors.first, width: 2)
                    : null,
              ),
              child: Icon(
                icon,
                color: selectedStyle == "outline" ? colors.first : Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 11,
                color: _isDarkMode ? Colors.white70 : const Color(0xFF5A6062),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyToCurrentApp(BuildContext context) async {
    if (widget.app == null) return;
    final iconBytes = await _iconToBytes(
      icons.first,
      prismColors.first,
      selectedStyle,
    );
    if (iconBytes != null) {
      await platform.invokeMethod('createShortcut', {
        "name": "${widget.app!.name} (Prism)",
        "package": widget.app!.package,
        "icon": iconBytes,
      });
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Prism pack applied successfully!"),
            backgroundColor: Colors.green,
          ),
        );
    }
  }

  void _showPreviewAndApply(
    BuildContext context,
    IconData icon,
    String name,
    List<Color> colors,
  ) {
    final t = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "${t.applyIcon} $name?",
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          t.applyToApp
              .replaceAll('{style}', selectedStyle)
              .replaceAll('{app}', widget.app?.name ?? "app"),
          style: TextStyle(
            color: _isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.cancel, style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final iconBytes = await _iconToBytes(icon, colors, selectedStyle);
              if (iconBytes != null && widget.app != null) {
                await platform.invokeMethod('createShortcut', {
                  "name": "${widget.app!.name} ($name)",
                  "package": widget.app!.package,
                  "icon": iconBytes,
                });
                if (context.mounted)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        t.iconAppliedSuccess.replaceAll('{name}', name),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: colors.first),
            child: Text(t.apply),
          ),
        ],
      ),
    );
  }

  Future<Uint8List?> _iconToBytes(
    IconData iconData,
    List<Color> colors,
    String style,
  ) async {
    try {
      final size = 512.0;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final rect = Rect.fromLTWH(0, 0, size, size);

      if (style == "gradient") {
        final gradient = LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
      } else if (style == "solid") {
        canvas.drawRect(rect, Paint()..color = colors.first);
      } else {
        canvas.drawColor(Colors.transparent, BlendMode.clear);
      }

      final iconSize = size * 0.5;
      final paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontSize: iconSize, textAlign: TextAlign.center),
      );
      paragraphBuilder.pushStyle(
        ui.TextStyle(
          color: style == "outline" ? colors.first : Colors.white,
          fontFamily: iconData.fontFamily,
        ),
      );
      paragraphBuilder.addText(String.fromCharCode(iconData.codePoint));
      paragraphBuilder.pop();
      final paragraph = paragraphBuilder.build();
      paragraph.layout(ui.ParagraphConstraints(width: size));
      canvas.drawParagraph(
        paragraph,
        Offset((size - paragraph.width) / 2, (size - paragraph.height) / 2),
      );

      if (style == "outline") {
        final offset = Offset(
          (size - paragraph.width) / 2,
          (size - paragraph.height) / 2,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              offset.dx - 10,
              offset.dy - 10,
              paragraph.width + 20,
              paragraph.height + 20,
            ),
            Radius.circular(20),
          ),
          Paint()
            ..color = colors.first
            ..style = PaintingStyle.stroke
            ..strokeWidth = 8.0,
        );
      }

      final picture = recorder.endRecording();
      final img = await picture.toImage(size.toInt(), size.toInt());
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint("Error converting icon: $e");
      return null;
    }
  }
}
