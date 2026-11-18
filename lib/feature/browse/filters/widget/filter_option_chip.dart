import 'package:flutter/material.dart';

/// A single selectable pill inside a filter section.
class FilterOptionChip extends StatelessWidget {
  const FilterOptionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.fromLTRB(isSelected ? 10 : 14, 9, 14, 9),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withValues(alpha: 0.18)
              : colors.surfaceContainerHighest.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? colors.primary
                : colors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              child: isSelected
                  ? Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.check_rounded,
                  size: 15,
                  color: colors.secondary,
                ),
              )
                  : const SizedBox.shrink(),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? colors.secondary : colors.onSurfaceVariant,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
