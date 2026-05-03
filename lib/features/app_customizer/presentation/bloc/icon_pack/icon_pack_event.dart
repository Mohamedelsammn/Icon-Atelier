import 'package:equatable/equatable.dart';

abstract class IconPackEvent extends Equatable {
  const IconPackEvent();

  @override
  List<Object?> get props => [];
}

class LoadIconPackEvent extends IconPackEvent {
  final String packType; // 'carbon' or 'prism'
  const LoadIconPackEvent(this.packType);

  @override
  List<Object?> get props => [packType];
}

class FilterIconPackEvent extends IconPackEvent {
  final String category; // 'all', 'system', 'social', etc.
  const FilterIconPackEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class ToggleStyleEvent extends IconPackEvent {
  final String style; // 'outline' or 'solid' for Carbon, 'gradient' for Prism
  const ToggleStyleEvent(this.style);

  @override
  List<Object?> get props => [style];
}

class SelectIconEvent extends IconPackEvent {
  final int index;
  const SelectIconEvent(this.index);

  @override
  List<Object?> get props => [index];
}
