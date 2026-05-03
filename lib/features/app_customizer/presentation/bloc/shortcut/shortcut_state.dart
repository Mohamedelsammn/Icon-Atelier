import 'package:equatable/equatable.dart';

abstract class ShortcutState extends Equatable {
  const ShortcutState();
  
  @override
  List<Object> get props => [];
}

class ShortcutInitial extends ShortcutState {}

class ShortcutLoading extends ShortcutState {}

class ShortcutSuccess extends ShortcutState {
  final String appName;
  const ShortcutSuccess(this.appName);

  @override
  List<Object> get props => [appName];
}

class ShortcutError extends ShortcutState {
  final String message;
  const ShortcutError(this.message);

  @override
  List<Object> get props => [message];
}
