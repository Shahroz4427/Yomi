import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/schedule_entry.dart';
import 'package:yomi/feature/schedule/widget/schedule_status_color.dart';
import 'package:yomi/shared/widgets/poster_image.dart';

/// One scheduled episode: poster, title, genre, episode number, status and
/// release time.
class ScheduleTile extends StatelessWidget {
  const ScheduleTile({super.key, required this.entry, required this.onTap});

  final ScheduleEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    final anime = entry.anime;
    final statusColor = entry.status.color;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          PosterImage(
            path: anime.image,
            width: 58,
            height: 78,
            borderRadius: 9,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${anime.type}  ·  ${entry.genre}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.secondaryTextColor,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Episode ${entry.episode}',
                  style: const TextStyle(
                    color: AppTheme.secondaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  entry.status.label,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 11,
                    color: AppTheme.secondaryTextColor,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    entry.time,
                    style: const TextStyle(
                      color: AppTheme.secondaryTextColor,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
