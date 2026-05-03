import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IconItem extends Equatable {
  final IconData outlineIcon;
  final IconData solidIcon;
  final String name;
  final String category; // 'system', 'social', 'productivity'

  const IconItem({
    required this.outlineIcon,
    required this.solidIcon,
    required this.name,
    required this.category,
  });

  @override
  List<Object?> get props => [name, category];
}

abstract class IconPackState extends Equatable {
  const IconPackState();

  @override
  List<Object?> get props => [];
}

class IconPackInitial extends IconPackState {}

class IconPackLoading extends IconPackState {}

class IconPackLoaded extends IconPackState {
  final List<IconItem> allIcons;
  final List<IconItem> filteredIcons;
  final String selectedCategory;
  final String selectedStyle; // 'outline' | 'solid' | 'gradient'
  final int? selectedIndex;

  const IconPackLoaded({
    required this.allIcons,
    required this.filteredIcons,
    required this.selectedCategory,
    required this.selectedStyle,
    this.selectedIndex,
  });

  IconPackLoaded copyWith({
    List<IconItem>? allIcons,
    List<IconItem>? filteredIcons,
    String? selectedCategory,
    String? selectedStyle,
    int? selectedIndex,
  }) {
    return IconPackLoaded(
      allIcons: allIcons ?? this.allIcons,
      filteredIcons: filteredIcons ?? this.filteredIcons,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
        filteredIcons,
        selectedCategory,
        selectedStyle,
        selectedIndex,
      ];
}

class IconPackError extends IconPackState {
  final String message;
  const IconPackError(this.message);

  @override
  List<Object?> get props => [message];
}
