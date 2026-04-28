import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:iconschange/features/carbon%20pack/views/prism_pack_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:iconschange/features/carbon%20pack/views/carbon_pack_screen.dart';
import 'package:iconschange/features/home/presentation/models/app_info.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDetailsScreen extends StatefulWidget {
  final AppInfo app;
  const AppDetailsScreen({super.key, required this.app});

  @override
  State<AppDetailsScreen> createState() => _AppDetailsScreenState();
}

class _AppDetailsScreenState extends State<AppDetailsScreen> {
  static const platform = MethodChannel('apps_channel');
  bool _isDarkMode = false;
  String _language = 'en';

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

  /// ===== PICK IMAGE =====
  Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    return await file.readAsBytes();
  }

  /// ===== CREATE SHORTCUT =====
  Future<void> createShortcut({
    required String name,
    required String package,
    required Uint8List icon,
  }) async {
    try {
      await platform.invokeMethod('createShortcut', {
        "name": name,
        "package": package,
        "icon": icon,
      });
    } catch (e) {
      debugPrint("Error creating shortcut: $e");
      rethrow;
    }
  }

  /// ===== SHOW NAME DIALOG =====
  Future<void> showNameDialog(
    BuildContext context,
    Uint8List imageBytes,
  ) async {
    final t = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController(
      text: widget.app.name,
    );

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        title: Text(
          t.editAppName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: MemoryImage(imageBytes),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: t.enterNewName,
                hintStyle: TextStyle(
                  color: _isDarkMode ? Colors.grey[500] : Colors.grey[400],
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: _isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            child: Text(t.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await createShortcut(
                  name: controller.text,
                  package: widget.app.package,
                  icon: imageBytes,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.shortcutCreatedSuccess),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${t.error}: ${e.toString()}"),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(t.createShortcut),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF1F3F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ===== APP BAR =====
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      t.iconAtelier,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: const Color(0xFF4F46E5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: _isDarkMode
                              ? const Color(0xFF1E1E1E)
                              : Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (_) => Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.info_outline,
                                    color: _isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                  title: Text(
                                    t.appInfo,
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        backgroundColor: _isDarkMode
                                            ? const Color(0xFF1E1E1E)
                                            : Colors.white,
                                        title: Text(
                                          t.appInfo,
                                          style: TextStyle(
                                            color: _isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${t.name}: ${widget.app.name}",
                                              style: TextStyle(
                                                color: _isDarkMode
                                                    ? Colors.white70
                                                    : Colors.black54,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "${t.package}: ${widget.app.package}",
                                              style: TextStyle(
                                                color: _isDarkMode
                                                    ? Colors.white70
                                                    : Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            style: TextButton.styleFrom(
                                              foregroundColor: const Color(
                                                0xFF4F46E5,
                                              ),
                                            ),
                                            child: Text(t.ok),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.help_outline,
                                    color: _isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                  title: Text(
                                    t.help,
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ===== ICON =====
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.memory(widget.app.iconBytes, fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                widget.app.name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                t.targetApplication,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 30),

              /// ===== CURATED PACKS =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    t.curatedPacks,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _carbonCard(context)),
                    const SizedBox(width: 12),
                    Expanded(child: _prismCard(context)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ===== CUSTOM ART =====
              GestureDetector(
                onTap: () async {
                  final image = await pickImage();
                  if (image == null) return;
                  await showNameDialog(context, image);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 30),
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
                    border: Border.all(color: const Color(0x26ADB3B5)),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: const Color(
                          0xFF4F46E5,
                        ).withOpacity(0.1),
                        child: const Icon(
                          Icons.image,
                          color: Color(0xFF4F46E5),
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t.uploadFromGallery,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.uploadHint,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // تم إزالة زر Apply Custom Icon من هنا
            ],
          ),
        ),
      ),
    );
  }

  /// ===== CARBON CARD =====
  Widget _carbonCard(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CarbonPackScreen(app: widget.app)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: const Color(0x26ADB3B5)),
        ),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _whiteIcon(Icons.message, _isDarkMode),
                _whiteIcon(Icons.camera_alt, _isDarkMode),
                _whiteIcon(Icons.mail, _isDarkMode),
                _whiteIcon(Icons.flag, _isDarkMode),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              t.carbonPack,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              _language == 'en' ? "Monochrome outline" : "مخطط أحادي اللون",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// ===== PRISM CARD =====
  Widget _prismCard(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PrismPackScreen(app: widget.app)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: const Color(0x26ADB3B5)),
        ),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _gradientIcon(
                  Icons.message,
                  Color(0xFFF093FB),
                  Color(0xFFF5576C),
                ),
                _gradientIcon(
                  Icons.camera_alt,
                  Color(0xFF4FACFE),
                  Color(0xFF00F2FE),
                ),
                _gradientIcon(Icons.mail, Color(0xFF43E97B), Color(0xFF38F9D7)),
                _gradientIcon(Icons.flag, Color(0xFFFA709A), Color(0xFFFEE140)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              t.prismPack,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              _language == 'en' ? "Vibrant gradients" : "تدرجات لونية نابضة",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===== CARBON ICON =====
class _whiteIcon extends StatelessWidget {
  final IconData icon;
  final bool isDarkMode;
  const _whiteIcon(this.icon, this.isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x26ADB3B5)),
      ),
      child: Icon(
        icon,
        size: 22,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}

/// ===== PRISM ICON =====
class _gradientIcon extends StatelessWidget {
  final IconData icon;
  final Color startColor;
  final Color endColor;

  const _gradientIcon(this.icon, this.startColor, this.endColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 22, color: Colors.white),
    );
  }
}
