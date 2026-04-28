import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconschange/core/localization/app_localizations.dart';
import 'package:iconschange/features/app_detailes/views/app_details_screen.dart';
import 'package:iconschange/features/home/presentation/models/app_info.dart';
import 'package:iconschange/features/settings/views/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Function? onSettingsChanged;
  const HomeScreen({super.key, this.onSettingsChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('apps_channel');

  List<AppInfo> _apps = [];
  List<AppInfo> _filteredApps = [];
  bool _isLoading = true;
  bool _isDarkMode = false;
  String _language = 'en';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadApps();
    _searchController.addListener(_filterApps);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _language = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> _loadApps() async {
    try {
      final List<dynamic> result = await platform.invokeMethod('getApps');

      final apps = result.map((app) {
        return AppInfo(
          name: app['name'],
          package: app['package'],
          iconBytes: Uint8List.fromList(List<int>.from(app['icon'])),
        );
      }).toList();

      setState(() {
        _apps = apps;
        _filteredApps = apps;
        _isLoading = false;
      });
    } catch (e) {
      print("ERROR: $e");
      setState(() => _isLoading = false);
    }
  }

  void _filterApps() {
    final q = _searchController.text.toLowerCase();

    setState(() {
      _filteredApps = _apps
          .where((a) => a.name.toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFF4F46E5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _language == 'en'
                        ? 'Loading apps...'
                        : 'جاري تحميل التطبيقات...',
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withOpacity(0.08),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 24),
                        Text(
                          t.iconAtelier,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4F46E5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                            if (result == true) {
                              _loadSettings();
                              // استدعاء الـ callback إذا كان موجود
                              if (widget.onSettingsChanged != null) {
                                widget.onSettingsChanged!();
                              }
                            }
                          },
                          child: Icon(
                            Icons.settings,
                            color: _isDarkMode
                                ? Colors.white70
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          t.chooseApp,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          t.selectApp,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: _isDarkMode
                                ? const Color(0xFF2C2C2C)
                                : const Color(0xFFE5E9EB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: _isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                              border: InputBorder.none,
                              hintText: t.searchApplications,
                              hintStyle: TextStyle(
                                color: _isDarkMode
                                    ? Colors.grey[500]
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            itemCount: _filteredApps.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 16,
                                ),
                            itemBuilder: (context, index) {
                              final app = _filteredApps[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          AppDetailsScreen(app: app),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: _isDarkMode
                                            ? const Color(0xFF2C2C2C)
                                            : const Color(0xFFE5E9EB),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Image.memory(app.iconBytes),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      app.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: _isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
