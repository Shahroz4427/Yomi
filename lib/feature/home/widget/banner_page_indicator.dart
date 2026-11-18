import 'package:flutter/material.dart';

/// Vertical dots that show and change the current banner.
class BannerPageIndicator extends StatelessWidget {
  const BannerPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.onSelected,
  });

  final int count;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final selected = currentIndex == index;

        return Semantics(
          button: true,
          selected: selected,
          label: 'Banner ${index + 1}',
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelected(index),
            child: SizedBox(
              width: 30,
              height: 32,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  width: 6,
                  height: selected ? 22 : 6,
                  decoration: BoxDecoration(
                    color: selected ? primary : Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.4),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
