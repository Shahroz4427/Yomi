import 'package:flutter/material.dart';

/// "Filter" button next to the categories. Highlights itself and shows a
/// badge when [activeCount] is greater than zero.
class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.activeCount,
    required this.onTap,
  });

  final int activeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final hasFilters = activeCount > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: hasFilters
              ? colors.primary.withValues(alpha: 0.18)
              : colors.surface,
          borderRadius: BorderRadius.circular(9),
          border: hasFilters ? Border.all(color: colors.primary) : null,
        ),
        child: Row(
          children: [
            Icon(Icons.tune_rounded, size: 16, color: colors.secondary),
            const SizedBox(width: 5),
            Text(
              'Filter',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface,
              ),
            ),
            if (hasFilters) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$activeCount',
                  style: TextStyle(
                    color: colors.onPrimary,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
