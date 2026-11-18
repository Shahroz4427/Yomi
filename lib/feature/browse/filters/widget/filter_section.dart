import 'package:flutter/material.dart';
import 'package:yomi/feature/browse/filters/filter_options.dart';
import 'package:yomi/feature/browse/filters/widget/filter_option_chip.dart';

/// One filter group: icon + title + selection badge, then its option chips.
class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.isMulti,
    required this.onToggle,
  });

  final String title;
  final List<String> options;
  final Set<String> selected;
  final bool isMulti;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: title,
            selected: selected,
            isMulti: isMulti,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              for (final option in options)
                FilterOptionChip(
                  label: option,
                  isSelected: selected.contains(option),
                  onTap: () => onToggle(option),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.selected,
    required this.isMulti,
  });

  final String title;
  final Set<String> selected;
  final bool isMulti;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Icon(
          kFilterIcons[title] ?? Icons.label_rounded,
          size: 16,
          color: colors.secondary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (isMulti) ...[
          const SizedBox(width: 8),
          Text(
            'Pick several',
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
          ),
        ],
        const Spacer(),
        if (selected.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isMulti ? '${selected.length}' : selected.first,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.secondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
