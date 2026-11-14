import 'package:flutter/material.dart';
import 'package:yomi/feature/browse/filters/filter_options.dart';

/// Row of removable tags that summarises what is currently selected.
/// Collapses to nothing when there are no selections.
class SelectedFiltersRow extends StatelessWidget {
  const SelectedFiltersRow({
    super.key,
    required this.filters,
    required this.onRemove,
  });

  final FilterSelection filters;

  /// Called with (group, option) when a tag is tapped.
  final void Function(String group, String option) onRemove;

  @override
  Widget build(BuildContext context) {
    final isEmpty = countFilters(filters) == 0;

    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: isEmpty
          ? const SizedBox(width: double.infinity)
          : SizedBox(
              height: 46,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                children: [
                  for (final entry in filters.entries)
                    for (final value in entry.value)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _SelectedTag(
                          label: value,
                          onRemove: () => onRemove(entry.key, value),
                        ),
                      ),
                ],
              ),
            ),
    );
  }
}

class _SelectedTag extends StatelessWidget {
  const _SelectedTag({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: colors.onPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.close_rounded, size: 14, color: colors.onPrimary),
          ],
        ),
      ),
    );
  }
}
