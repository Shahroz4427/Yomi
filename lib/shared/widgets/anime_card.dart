import 'package:flutter/material.dart';
import 'package:yomi/model/anime_item.dart';
import 'package:yomi/shared/widgets/anime_poster_badge.dart';

class AnimeCard extends StatelessWidget {
  final AnimeItem anime;
  final VoidCallback? onTap;

  const AnimeCard({
    super.key,
    required this.anime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 150;

        return Material(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster section
                Expanded(
                  flex: 7,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Poster image
                      Image.asset(
                        anime.image,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                        errorBuilder: (context, error, stackTrace) {
                          return ColoredBox(
                            color: colors.surfaceContainerHighest,
                            child: Center(
                              child: Icon(
                                Icons.movie_outlined,
                                size: 36,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),

                      // Subtle bottom gradient
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x22000000),
                              Colors.transparent,
                              Color(0x99000000),
                            ],
                            stops: [0.0, 0.45, 1.0],
                          ),
                        ),
                      ),

                      // Anime type
                      Positioned(
                        top: 8,
                        left: 7,
                        child: AnimePosterBadge(
                          child: Text(
                            anime.type.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isCompact ? 8 : 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),

                      // Rating
                      if (anime.rating != 0.0)
                        Positioned(
                          top: 8,
                          right: 7,
                          child: AnimePosterBadge(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 13,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  anime.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Upcoming episode
                      if (anime.nextEpisode != null)
                        Positioned(
                          bottom: 8,
                          left: 7,
                          right: 7,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimePosterBadge(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF36D399),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      anime.nextEpisode!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Information section
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      isCompact ? 8 : 10,
                      7,
                      isCompact ? 8 : 10,
                      7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Expanded(
                          child: Text(
                            anime.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurface,
                              fontSize: isCompact ? 11 : 13,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Rating and episodes
                        Row(
                          children: [
                            if (anime.rating != 0.0) ...[
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 13,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                anime.rating.toStringAsFixed(1),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: Container(
                                  width: 3,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: colors.outline,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],

                            Expanded(
                              child: Text(
                                anime.episodes,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Anime badge
                        if (anime.badge != null) ...[
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.13),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                anime.badge!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colors.secondary,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


