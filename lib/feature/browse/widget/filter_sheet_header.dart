import 'package:flutter/material.dart';

/// Title area of the filter sheet: icon badge, title, status line, close button.
class FilterSheetHeader extends StatelessWidget {
  const FilterSheetHeader({
    super.key,
    required this.selectedCount,
    required this.onClose,
  });

  final int selectedCount;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.tune_rounded, color: colors.secondary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter anime',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: Text(
                    selectedCount == 0
                        ? 'Pick what you want to see'
                        : '$selectedCount selected',
                    key: ValueKey(selectedCount == 0),
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close_rounded, color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}