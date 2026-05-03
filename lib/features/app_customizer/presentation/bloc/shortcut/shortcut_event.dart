import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class ShortcutEvent extends Equatable {
  const ShortcutEvent();

  @override
  List<Object> get props => [];
}

class CreateShortcutEvent extends ShortcutEvent {
  final String name;
  final String package;
  final Uint8List icon;

  const CreateShortcutEvent({
    required this.name,
    required this.package,
    required this.icon,
  });

  @override
  List<Object> get props => [name, package, icon];
}
