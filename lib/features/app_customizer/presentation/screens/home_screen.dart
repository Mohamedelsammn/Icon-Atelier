import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../injection_container.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../bloc/apps/apps_bloc.dart';
import '../bloc/apps/apps_event.dart';
import '../bloc/apps/apps_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AppsBloc>()..add(LoadApps()),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<AppsBloc>().add(SearchApps(_searchController.text));
    });

    // Check for permission after the frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowPermissionDialog();
    });
  }

  Future<void> _checkAndShowPermissionDialog() async {
    final prefs = sl<SharedPreferences>();
    final hasSeenPermissionDialog =
        prefs.getBool('has_permission_shown') ?? false;

    if (!hasSeenPermissionDialog) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    final t = AppLocalizations.of(context)!;
    final isDarkMode = context.read<SettingsBloc>().state.isDarkMode;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode
                        ? const Color(0xFF2C2C2C)
                        : const Color(0xFFF5F5F5),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/Icon Graphic (Intentional Asymmetry & Layering)_margin.svg',
                      width: 50,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  t.allowPermission,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : const Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  t.permissionDesc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
                        ? Colors.grey[400]
                        : const Color(0xFF6B6B6B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(dialogContext);
                      final prefs = sl<SharedPreferences>();
                      await prefs.setBool('has_permission_shown', true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E45E4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      t.allow,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () async {
                    final prefs = sl<SharedPreferences>();
                    await prefs.setBool('has_permission_shown', true);
                    SystemNavigator.pop();
                  },
                  child: Text(
                    t.exit,
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.grey[400]
                          : const Color(0xFF999999),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isDarkMode = context.select((SettingsBloc b) => b.state.isDarkMode);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          t.chooseApp,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: isDarkMode ? Colors.white70 : const Color(0xFF94A3B8),
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.settings);
            },
          ),
        ],
      ),
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      body: BlocBuilder<AppsBloc, AppsState>(
        builder: (context, state) {
          if (state is AppsLoading || state is AppsInitial) {
            return _buildLoading(context, isDarkMode, t);
          } else if (state is AppsError) {
            return Center(child: Text(state.message));
          } else if (state is AppsLoaded) {
            return _buildContent(context, state, isDarkMode, t);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context, bool isDarkMode, AppLocalizations t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
          ),
          const SizedBox(height: 20),
          Text(
            t.loadingApps,
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppsLoaded state,
    bool isDarkMode,
    AppLocalizations t,
  ) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  t.selectApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSearchBar(isDarkMode, t),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: state.filteredApps.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.getGridCrossAxisCount(
                        context,
                      ),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final app = state.filteredApps[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.appDetails,
                            arguments: app,
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: ClipRRect(
                                child: Image.memory(
                                  app.iconBytes,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) { 
                                    return Icon(
                                      Icons.apps,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              app.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.white : Colors.black,
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
    );
  }

  Widget _buildSearchBar(bool isDarkMode, AppLocalizations t) {
    return TextField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: _searchController,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      decoration: InputDecoration(
        fillColor: isDarkMode
            ? const Color(0xFF2C2C2C)
            : const Color(0xFFE5E9EB),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[400]! : Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[400]! : Colors.grey[600]!,
          ),
        ),
        hoverColor: isDarkMode
            ? const Color(0xFF2C2C2C)
            : const Color(0xFFE5E9EB),
        hintText: t.searchApplications,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
        ),
      ),
    );
  }
}
