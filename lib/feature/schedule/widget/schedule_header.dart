import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// "Airing Schedule" title with a button that jumps back to today.
class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({super.key, required this.onTodayTap});

  final VoidCallback onTodayTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
              ),
            ),
            child: const Icon(
              Icons.calendar_month_rounded,
              color: AppTheme.secondaryColor,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Airing Schedule',
                  style: TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Track your favorite anime episodes',
                  style: TextStyle(
                    color: AppTheme.secondaryTextColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTodayTap,
            tooltip: 'Today',
            icon: const Icon(
              Icons.today_rounded,
              color: AppTheme.secondaryColor,
              size: 23,
            ),
          ),
        ],
      ),
    );
  }
}
