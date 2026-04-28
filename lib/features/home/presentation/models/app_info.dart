import 'dart:typed_data';

class AppInfo {
  final String name;
  final String package;
  final Uint8List iconBytes;

  AppInfo({required this.name, required this.package, required this.iconBytes});
}
