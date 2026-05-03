import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class AppEntity extends Equatable {
  final String name;
  final String package;
  final Uint8List iconBytes;

  const AppEntity({
    required this.name,
    required this.package,
    required this.iconBytes,
  });

  @override
  List<Object?> get props => [name, package, iconBytes];
}
