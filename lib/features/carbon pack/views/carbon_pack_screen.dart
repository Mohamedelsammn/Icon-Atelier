import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:iconschange/features/home/presentation/models/app_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarbonPackScreen extends StatefulWidget {
  final AppInfo? app;
  const CarbonPackScreen({super.key, this.app});

  @override
  State<CarbonPackScreen> createState() => _CarbonPackScreenState();
}

class _CarbonPackScreenState extends State<CarbonPackScreen> {
  bool isOutline = true;
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
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      t.carbonPack,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    // تم إزالة زر Apply من هنا
                    const SizedBox(width: 40), // للحفاظ على التوازن
                  ],
                ),
              ),

              /// ===== HERO =====
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    colors: [Colors.black, Color(0xFF2C2C2C)],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      t.carbonPackTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.carbonPackDesc,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      "assets/images/Hero Preview Cluster.svg",
                      height: 150,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ===== SWITCH =====
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _switchItem(
                    t.solid,
                    !isOutline,
                    () => setState(() => isOutline = false),
                  ),
                  _switchItem(
                    t.outline,
                    isOutline,
                    () => setState(() => isOutline = true),
                  ),
                ],
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
                        border: Border.all(color: const Color(0x26ADB3B5)),
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
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: icons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return _iconItem(icons[index], iconNames[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ===== SWITCH =====
  Widget _switchItem(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? (_isDarkMode ? Colors.grey[800] : Colors.white)
              : (_isDarkMode ? Colors.grey[700] : Colors.grey[300]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active
                ? (_isDarkMode ? Colors.white : Colors.black)
                : (_isDarkMode ? Colors.white70 : Colors.black54),
          ),
        ),
      ),
    );
  }

  /// ===== ICON SHARED UI =====
  Widget _buildIconPreview(IconData icon, {double size = 60}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOutline
            ? (_isDarkMode ? Colors.grey[800] : Colors.white)
            : (_isDarkMode ? Colors.grey[900] : Colors.black),
        borderRadius: BorderRadius.circular(16),
        border: isOutline
            ? Border.all(
                color: (_isDarkMode ? Colors.white70 : Colors.black)
                    .withOpacity(0.8),
                width: 1.2,
              )
            : null,
      ),
      child: Icon(
        icon,
        color: isOutline
            ? (_isDarkMode ? Colors.white : Colors.black)
            : (_isDarkMode ? Colors.white : Colors.white),
        size: size * 0.5,
      ),
    );
  }

  /// ===== GRID ITEM =====
  Widget _iconItem(IconData icon, String name) {
    return GestureDetector(
      onTap: () {
        if (widget.app != null) {
          _showPreviewAndApply(context, icon, name);
        }
      },
      child: Column(
        children: [
          _buildIconPreview(icon),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: _isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  /// ===== PREVIEW DIALOG =====
  void _showPreviewAndApply(BuildContext context, IconData icon, String name) {
    final t = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        title: Row(
          children: [
            _buildIconPreview(icon, size: 40),
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
              .replaceAll('{style}', isOutline ? t.outline : t.solid)
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
              final iconBytes = await _iconToBytes(icon);
              await platform.invokeMethod('createShortcut', {
                "name": name,
                "package": widget.app!.package,
                "icon": iconBytes,
              });
              if (context.mounted) {
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
            ),
            child: Text(t.apply),
          ),
        ],
      ),
    );
  }

  /// ===== ICON TO BYTES =====
  Future<Uint8List?> _iconToBytes(IconData iconData) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = 512.0;

    final bgColor = isOutline
        ? (_isDarkMode ? Colors.grey[800]! : Colors.white)
        : (_isDarkMode ? Colors.grey[900]! : Colors.black);
    final iconColor = isOutline
        ? (_isDarkMode ? Colors.white : Colors.black)
        : Colors.white;

    final paint = Paint()..color = bgColor;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size, size),
        const Radius.circular(100),
      ),
      paint,
    );

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: size * 0.25,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: iconColor,
      ),
    );

    textPainter.layout();

    final offset = Offset(
      (size - textPainter.width) / 2,
      (size - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  }
}
