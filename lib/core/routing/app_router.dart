import 'package:flutter/material.dart';
import '../../features/app_customizer/domain/entities/app_entity.dart';
import '../../features/app_customizer/presentation/screens/app_details_screen.dart';
import '../../features/app_customizer/presentation/screens/carbon_pack_screen.dart';
import '../../features/app_customizer/presentation/screens/home_screen.dart';
import '../../features/app_customizer/presentation/screens/prism_pack_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/splash/views/splash_screen_view.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteNames.appDetails:
        if (settings.arguments is AppEntity) {
          final app = settings.arguments as AppEntity;
          return MaterialPageRoute(builder: (_) => AppDetailsScreen(app: app));
        }
        return _errorRoute('AppDetailsScreen requires an AppEntity argument');
      case RouteNames.carbonPack:
        return MaterialPageRoute(builder: (_) => const CarbonPackScreen());
      case RouteNames.prismPack:
        return MaterialPageRoute(builder: (_) => const PrismPackScreen());
      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Routing Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      );
    });
  }
}
