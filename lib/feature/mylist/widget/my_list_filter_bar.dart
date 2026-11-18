import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/my_list_entry.dart';

/// Horizontally scrolling status chips: "All" plus every [MyListStatus].
class MyListFilterBar extends StatelessWidget {
  const MyListFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  /// The selected status, or null for "All".
  final MyListStatus? selected;
  final ValueChanged<MyListStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    // null stands for "All".
    final List<MyListStatus?> options = [null, ...MyListStatus.values];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = options[index];

          return _FilterPill(
            label: status?.label ?? 'All',
            isSelected: status == selected,
            onTap: () => onSelected(status),
          );
        },
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.secondaryColor : AppTheme.borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.secondaryTextColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
