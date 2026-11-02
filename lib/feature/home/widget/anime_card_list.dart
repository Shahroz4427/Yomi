import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/model/anime_item.dart';
import 'package:yomi/shared/widgets/anime_card.dart';
import 'package:yomi/shared/widgets/arrow_button.dart';

class AnimeCardList extends StatefulWidget {

  final String title;
  final VoidCallback onViewAll;
  final ValueChanged<AnimeItem> onAnimeTap;
  final List<AnimeItem> items;
  final double cardWidth;
  final IconData topIcon;
  final Color topIconColor;

  const AnimeCardList({
    super.key,
    required this.title,
    required this.onViewAll,
    required this.onAnimeTap,
    required this.items,
    required this.cardWidth,
    required this.topIcon,
    required this.topIconColor
  });

  @override
  State<AnimeCardList> createState() => _AnimeCardListState();
}

class _AnimeCardListState extends State<AnimeCardList> {
  final ScrollController _scrollController = ScrollController();

  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateArrows);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateArrows();
    });
  }

  @override
  void didUpdateWidget(covariant AnimeCardList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items.length != widget.items.length ||
        oldWidget.cardWidth != widget.cardWidth) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _updateArrows();
      });
    }
  }

  void _updateArrows() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    final canLeft = position.pixels > 1;
    final canRight = position.pixels < position.maxScrollExtent - 1;

    if (canLeft != _canScrollLeft || canRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  void _scroll(bool forward) {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final distance = position.viewportDimension * 0.8;

    final target = (position.pixels + (forward ? distance : -distance))
        .clamp(0.0, position.maxScrollExtent)
        .toDouble();

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateArrows);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section heading and navigation controls.
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: [
               Icon(
                widget.topIcon,
                color: widget.topIconColor,
                size: 22,
              ),
              const SizedBox(width: 5),

              Expanded(
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              TextButton(
                onPressed: widget.onViewAll,
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.accentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('View all'),
                    SizedBox(width: 3),
                    Icon(Icons.chevron_right_rounded, size: 17),
                  ],
                ),
              ),

              const SizedBox(width: 4),

              ArrowButton(
                icon: Icons.chevron_left_rounded,
                enabled: _canScrollLeft,
                onTap: () => _scroll(false),
              ),

              const SizedBox(width: 6),

              ArrowButton(
                icon: Icons.chevron_right_rounded,
                enabled: _canScrollRight,
                onTap: () => _scroll(true),
              ),
            ],
          ),
        ),

        // Horizontal anime list.
        SizedBox(
          height: 285,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 4),
            itemCount: widget.items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final anime = widget.items[index];

              return SizedBox(
                width: widget.cardWidth,
                child: AnimeCard(
                  anime: anime,
                  onTap: () => widget.onAnimeTap(anime),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
