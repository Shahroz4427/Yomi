import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/my_list_entry.dart';
import 'package:yomi/feature/mylist/widget/my_list_tile.dart';

/// The saved anime as a column of tiles, or an empty state.
class MyListEntries extends StatelessWidget {
  const MyListEntries({
    super.key,
    required this.entries,
    required this.onEntryTap,
    required this.onOptionsTap,
  });

  final List<MyListEntry> entries;
  final ValueChanged<MyListEntry> onEntryTap;
  final VoidCallback onOptionsTap;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const _EmptyState();
    }

    return Column(
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MyListTile(
              entry: entry,
              onTap: () => onEntryTap(entry),
              onOptionsTap: onOptionsTap,
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 48,
            color: AppTheme.secondaryTextColor,
          ),
          SizedBox(height: 12),
          Text(
            'No anime found',
            style: TextStyle(
              color: AppTheme.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Your anime collection will appear here.',
            style: TextStyle(color: AppTheme.secondaryTextColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
