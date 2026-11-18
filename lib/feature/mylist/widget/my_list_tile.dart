import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/my_list_entry.dart';
import 'package:yomi/shared/widgets/poster_image.dart';

/// One saved anime: poster, details, progress (while watching) and status.
class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.entry,
    required this.onOptionsTap,
  });

  final MyListEntry entry;
  final VoidCallback onOptionsTap;

  @override
  Widget build(BuildContext context) {
    final anime = entry.anime;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PosterImage(
            path: anime.image,
            width: 82,
            height: 112,
            borderRadius: 9,
          ),
          const SizedBox(width: 12),
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
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${anime.type}  •  ${anime.episodes}',
                  style: const TextStyle(
                    color: AppTheme.secondaryTextColor,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF5C451),
                      size: 14,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      anime.rating.toString(),
                      style: const TextStyle(
                        color: AppTheme.primaryTextColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (entry.status == MyListStatus.watching) ...[
                  _WatchProgress(
                    watchedEpisodes: entry.watchedEpisodes,
                    progress: entry.progress,
                  ),
                  const SizedBox(height: 9),
                ],
                _StatusBadge(label: entry.status.label),
              ],
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onOptionsTap,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppTheme.secondaryTextColor,
              size: 20,
            ),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _WatchProgress extends StatelessWidget {
  const _WatchProgress({required this.watchedEpisodes, required this.progress});

  final int watchedEpisodes;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Episode $watchedEpisodes',
              style: const TextStyle(
                color: AppTheme.secondaryTextColor,
                fontSize: 10,
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                color: AppTheme.secondaryColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: AppTheme.borderColor,
            valueColor: const AlwaysStoppedAnimation(AppTheme.primaryColor),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.secondaryColor,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
