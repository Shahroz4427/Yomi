import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/shared/widgets/poster_image.dart';

/// One row of the ranking: rank, poster, title with info chips, and rating.
/// The first place gets a highlighted background.
class TopAnimeTile extends StatelessWidget {
  const TopAnimeTile({super.key, required this.anime, required this.rank});

  final AnimeItem anime;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final isFirst = rank == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        gradient: isFirst
            ? LinearGradient(
                colors: [
                  AppTheme.primaryColor.withValues(alpha: 0.18),
                  AppTheme.surfaceColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isFirst ? null : AppTheme.surfaceColor.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFirst
              ? AppTheme.primaryColor.withValues(alpha: 0.65)
              : AppTheme.borderColor.withValues(alpha: 0.45),
          width: isFirst ? 1.2 : 0.7,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 42, child: Center(child: _RankIndicator(rank: rank))),
          const SizedBox(width: 10),
          PosterImage(path: anime.image, width: 66, height: 88),
          const SizedBox(width: 12),
          Expanded(child: _Details(anime: anime, isFirst: isFirst)),
          const SizedBox(width: 6),
          _Rating(rating: anime.rating),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.anime, required this.isFirst});

  final AnimeItem anime;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          anime.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isFirst
                ? AppTheme.secondaryColor
                : AppTheme.primaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 9),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            _InfoChip(label: anime.type),
            _InfoChip(label: '${anime.episodes} eps'),
          ],
        ),
      ],
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
            const SizedBox(width: 3),
            Text(
              rating.toString(),
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        const Text(
          'Rating',
          style: TextStyle(color: AppTheme.secondaryTextColor, fontSize: 10),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.secondaryTextColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Medal for the top three places, plain number afterwards.
class _RankIndicator extends StatelessWidget {
  const _RankIndicator({required this.rank});

  final int rank;

  static const List<Color> _medalColors = [
    Color(0xFFFFC83D), // Gold
    Color(0xFFBFC7D5), // Silver
    Color(0xFFCD8959), // Bronze
  ];

  @override
  Widget build(BuildContext context) {
    if (rank <= 3) {
      final medalColor = _medalColors[rank - 1];

      return Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: medalColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.emoji_events_rounded, color: medalColor, size: 23),
      );
    }

    return Text(
      rank.toString(),
      style: const TextStyle(
        color: AppTheme.secondaryColor,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
