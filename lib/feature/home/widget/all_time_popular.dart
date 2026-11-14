import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:yomi/data/anime_data.dart';
import 'package:flutter/material.dart';

class AllTimePopular extends StatelessWidget {
  const AllTimePopular({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'All-Time Popular',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: AnimeData.allTimePopularAnimes,
        cardWidth: 150,
        topIcon: Icons.star,
        topIconColor: Colors.amber,
      ),
    );
  }
}
