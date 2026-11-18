import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Three counters: watching, plan to watch and completed.
class MyListStats extends StatelessWidget {
  const MyListStats({
    super.key,
    required this.watching,
    required this.planToWatch,
    required this.completed,
  });

  final int watching;
  final int planToWatch;
  final int completed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Watching',
            count: watching,
            icon: Icons.play_circle_outline_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            title: 'Plan to Watch',
            count: planToWatch,
            icon: Icons.bookmark_border_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            title: 'Completed',
            count: completed,
            icon: Icons.check_circle_outline_rounded,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
  });

  final String title;
  final int count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.secondaryColor, size: 20),
          const SizedBox(height: 12),
          Text(
            count.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: AppTheme.primaryTextColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
