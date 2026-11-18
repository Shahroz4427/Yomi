import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/feature/home/widget/anime_card_list_header.dart';
import 'package:yomi/shared/widgets/anime_card.dart';

/// Horizontally scrolling list of [AnimeCard]s with a heading and arrow
/// buttons that scroll the list.
class AnimeCardList extends StatefulWidget {
  const AnimeCardList({
    super.key,
    required this.title,
    required this.onViewAll,
    required this.onAnimeTap,
    required this.items,
    required this.cardWidth,
    required this.topIcon,
    required this.topIconColor,
  });

  final String title;
  final VoidCallback onViewAll;
  final ValueChanged<AnimeItem> onAnimeTap;
  final List<AnimeItem> items;
  final double cardWidth;
  final IconData topIcon;
  final Color topIconColor;

  @override
  State<AnimeCardList> createState() => _AnimeCardListState();
}

class _AnimeCardListState extends State<AnimeCardList> {
  static const double _listHeight = 285;

  final ScrollController _scrollController = ScrollController();

  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateArrows);

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateArrows());
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

  void _scroll({required bool forward}) {
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
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimeCardListHeader(
          title: widget.title,
          icon: widget.topIcon,
          iconColor: widget.topIconColor,
          canScrollLeft: _canScrollLeft,
          canScrollRight: _canScrollRight,
          onViewAll: widget.onViewAll,
          onScrollLeft: () => _scroll(forward: false),
          onScrollRight: () => _scroll(forward: true),
        ),
        SizedBox(
          height: _listHeight,
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
