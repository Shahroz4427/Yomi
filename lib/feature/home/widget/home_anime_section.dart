import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';

/// One titled, horizontally scrolling anime row on the home page.
///
/// Replaces the former per-section widgets (CurrentlyAiring, TrendingNow,
/// ...) which only differed by title, icon and data.
class HomeAnimeSection extends StatelessWidget {
  const HomeAnimeSection({
    super.key,
    required this.title,
    required this.items,
    required this.icon,
    required this.iconColor,
    required this.onViewAll,
    required this.onAnimeTap,
  });

  final String title;
  final List<AnimeItem> items;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onViewAll;
  final ValueChanged<AnimeItem> onAnimeTap;

  static const double _cardWidth = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: title,
        onViewAll: onViewAll,
        onAnimeTap: onAnimeTap,
        items: items,
        cardWidth: _cardWidth,
        topIcon: icon,
        topIconColor: iconColor,
      ),
    );
  }
}
