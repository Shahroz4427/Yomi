import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/episode.dart';

/// One episode row: thumbnail with play icon, title and duration.
/// The episode that is currently playing is highlighted.
class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    super.key,
    required this.episode,
    required this.thumbnail,
    required this.onTap,
    this.isPlaying = false,
  });

  final Episode episode;

  /// Asset path of the image shown as thumbnail.
  final String thumbnail;
  final VoidCallback onTap;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppTheme.surfaceColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isPlaying ? AppTheme.primaryColor : AppTheme.borderColor,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _Thumbnail(path: thumbnail, isPlaying: isPlaying),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Episode ${episode.number}',
                        style: TextStyle(
                          color: isPlaying
                              ? AppTheme.secondaryColor
                              : AppTheme.primaryTextColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${episode.title}  ·  ${episode.duration}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppTheme.secondaryTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isPlaying
                      ? Icons.graphic_eq_rounded
                      : Icons.play_circle_outline_rounded,
                  color: isPlaying
                      ? AppTheme.secondaryColor
                      : AppTheme.secondaryTextColor,
                  size: 24,
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.path, required this.isPlaying});

  final String path;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: SizedBox(
        width: 104,
        height: 60,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(color: AppTheme.backgroundColor);
              },
            ),
            ColoredBox(color: Colors.black.withValues(alpha: 0.35)),
            Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
