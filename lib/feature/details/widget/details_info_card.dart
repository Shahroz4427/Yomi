import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/anime_details.dart';

/// Card with label / value rows (studio, status, release year, episodes).
class DetailsInfoCard extends StatelessWidget {
  const DetailsInfoCard({super.key, required this.details});

  final AnimeDetails details;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Studio', details.studio),
      ('Status', details.status),
      ('Released', details.releaseYear),
      ('Episodes', '${details.episodes.length}'),
      ('Type', details.anime.type),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            _InfoRow(label: rows[index].$1, value: rows[index].$2),
            if (index != rows.length - 1)
              const Divider(height: 1, color: AppTheme.borderColor),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.secondaryTextColor,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.primaryTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
