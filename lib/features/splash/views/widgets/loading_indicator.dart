import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final int activeIndex;
  final bool isDarkMode;

  const LoadingIndicator({
    super.key,
    required this.activeIndex,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: activeIndex == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == activeIndex
                ? const Color(0xFF4F46E5)
                : (isDarkMode ? Colors.grey[600] : const Color(0xFF745479)),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
