import 'dart:typed_data';
import 'package:flutter/services.dart';
import '../models/app_model.dart';

abstract class AppLocalDataSource {
  Future<List<AppModel>> getInstalledApps();
  Future<void> createShortcut({
    required String name,
    required String package,
    required Uint8List icon,
  });
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  static const platform = MethodChannel('apps_channel');

  @override
  Future<List<AppModel>> getInstalledApps() async {
    try {
      final List<dynamic> result = await platform.invokeMethod('getApps');
      return result.map((app) => AppModel.fromMap(app)).toList();
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
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
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }
}
