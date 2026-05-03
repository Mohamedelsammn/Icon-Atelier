import 'dart:typed_data';
import '../../domain/entities/app_entity.dart';

class AppModel extends AppEntity {
  const AppModel({
    required super.name,
    required super.package,
    required super.iconBytes,
  });

  factory AppModel.fromMap(Map<dynamic, dynamic> map) {
    return AppModel(
      name: map['name'] as String,
      package: map['package'] as String,
      iconBytes: Uint8List.fromList(List<int>.from(map['icon'])),
    );
  }
}
