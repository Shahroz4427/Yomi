import 'package:flutter/material.dart';
import 'package:yomi/data/anime_data.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';

class TrendingNow extends StatelessWidget {
  const TrendingNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'Trending Now',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: AnimeData.trendingNowAnimes,
        cardWidth: 150,
        topIcon: Icons.trending_up,
        topIconColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
