import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/feature/mylist/my_list_sort.dart';

/// List title, number of anime and the sort menu.
class MyListSectionHeader extends StatelessWidget {
  const MyListSectionHeader({
    super.key,
    required this.title,
    required this.count,
    required this.selectedSort,
    required this.onSortSelected,
  });

  final String title;
  final int count;
  final MyListSort selectedSort;
  final ValueChanged<MyListSort> onSortSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppTheme.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '$count Anime',
          style: const TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 11,
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<MyListSort>(
          initialValue: selectedSort,
          color: AppTheme.surfaceColor,
          icon: const Icon(
            Icons.sort_rounded,
            color: AppTheme.secondaryTextColor,
          ),
          onSelected: onSortSelected,
          itemBuilder: (context) {
            return [
              for (final sort in MyListSort.values)
                PopupMenuItem(
                  value: sort,
                  child: Text(
                    sort.label,
                    style: const TextStyle(
                      color: AppTheme.primaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
            ];
          },
        ),
      ],
    );
  }
}
