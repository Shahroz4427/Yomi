import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/schedule_entry.dart';
import 'package:yomi/feature/schedule/widget/schedule_status_color.dart';
import 'package:yomi/feature/schedule/widget/section_title.dart';

/// "Daily Overview" block with total, released and upcoming counters.
class DailyOverview extends StatelessWidget {
  const DailyOverview({
    super.key,
    required this.total,
    required this.released,
    required this.upcoming,
  });

  final int total;
  final int released;
  final int upcoming;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Daily Overview'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Total',
                  count: total,
                  icon: Icons.calendar_today_rounded,
                  color: AppTheme.secondaryColor,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _SummaryCard(
                  title: ScheduleStatus.released.label,
                  count: released,
                  icon: Icons.check_circle_outline_rounded,
                  color: ScheduleStatus.released.color,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _SummaryCard(
                  title: ScheduleStatus.upcoming.label,
                  count: upcoming,
                  icon: Icons.access_time_rounded,
                  color: ScheduleStatus.upcoming.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 13),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.borderColor.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 10),
          Text(
            count.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: AppTheme.primaryTextColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.secondaryTextColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
