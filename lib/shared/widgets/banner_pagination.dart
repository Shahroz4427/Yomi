import 'package:flutter/material.dart';
import 'package:yomi/model/anime_banner.dart';

import 'dart:ui' show ImageFilter;

class BannerPagination extends StatelessWidget {
  const BannerPagination({
    super.key,
    required this.banner,
    this.onWatchNow,
    this.onAddToList,
  });

  final AnimeBanner banner;
  final ValueChanged<AnimeBanner>? onWatchNow;
  final ValueChanged<AnimeBanner>? onAddToList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Very subtle blur keeps artwork almost completely sharp.
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 0.35, sigmaY: 0.35),
          child: Image.asset(
            banner.image,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
            errorBuilder: (context, error, stackTrace) {
              return ColoredBox(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: Icon(Icons.image_not_supported_outlined, size: 40),
                ),
              );
            },
          ),
        ),

        // Dark gradient improves text readability.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Color(0x08000000), Color(0x55000000), Color(0xE6000000)],
              stops: [0.0, 0.48, 1.0],
            ),
          ),
        ),

        // Bottom-left text and buttons.
        Positioned(
          left: 18,
          right: 48,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                banner.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                banner.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                banner.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: onWatchNow == null
                        ? null
                        : () => onWatchNow!(banner),
                    icon: const Icon(Icons.play_arrow_rounded, size: 19),
                    label: const Text('Watch Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Theme.of(context)
                          .colorScheme
                          .primary,
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      minimumSize: const Size(0, 40),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  OutlinedButton.icon(
                    onPressed: onAddToList == null
                        ? null
                        : () => onAddToList!(banner),
                    icon: const Icon(Icons.add_rounded, size: 18,color: Colors.white),
                    label: const Text('My List',style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      minimumSize: const Size(0, 40),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
