
import 'package:flutter/material.dart';
import 'package:yomi/model/anime_item.dart';
import 'card_badge.dart';

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

    return Material(
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14),
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
                  // Anime poster
                  Image.asset(
                    anime.image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                    errorBuilder: (_, _, _) {
                      return ColoredBox(
                        color: colors.surfaceContainerHighest,
                        child: const Center(
                          child: Icon(
                            Icons.movie_outlined,
                            size: 35,
                          ),
                        ),
                      );
                    },
                  ),

                  // Bottom gradient
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0x99000000),
                        ],
                        stops: [0.45, 1.0],
                      ),
                    ),
                  ),

                  // Anime type
                  Positioned(
                    top: 8,
                    left: 7,
                    child: CardBadge(
                      background: const Color(0xCC151515),
                      child: Text(
                        anime.type.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),

                  // Rating
                  Positioned(
                    top: 8,
                    right: 7,
                    child: CardBadge(
                      background: const Color(0xCC151515),
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
                      bottom: 9,
                      left: 7,
                      right: 7,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CardBadge(
                          background: const Color(0xE6151515),
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

            // Anime information
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    // Title
                    SizedBox(
                      height: 32, // Reserve space for exactly 2 lines
                      child: Text(
                        anime.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          height: 1.25,
                          color: colors.onSurface,
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    // Rating and episode information
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          anime.rating.toStringAsFixed(1),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: colors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: colors.outline,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${anime.episodes} Episodes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Anime badge
                    if (anime.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          anime.badge!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
