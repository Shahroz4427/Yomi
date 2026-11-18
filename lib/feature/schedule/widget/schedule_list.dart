import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/schedule_entry.dart';
import 'package:yomi/feature/schedule/widget/schedule_tile.dart';
import 'package:yomi/feature/schedule/widget/section_title.dart';

/// "<Day> Releases" heading and the episodes of that day, or an empty state.
class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key, required this.dayName, required this.entries});

  final String dayName;
  final List<ScheduleEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionTitle('$dayName Releases'),
              Text(
                '${entries.length} Episodes',
                style: const TextStyle(
                  color: AppTheme.secondaryTextColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          if (entries.isEmpty)
            const _EmptyState(message: 'No episodes found')
          else
            for (final entry in entries) ScheduleTile(entry: entry),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 35),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.event_busy_rounded,
            color: AppTheme.secondaryTextColor,
            size: 32,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              color: AppTheme.secondaryTextColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
