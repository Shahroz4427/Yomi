import 'package:yomi/data/anime_data.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:flutter/material.dart';

class ComingNextSeason extends StatelessWidget {
  const ComingNextSeason({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'Coming Next Season',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: AnimeData.comingNextSeasonAnimes,
        cardWidth: 150,
        topIcon: Icons.upcoming,
        topIconColor: Colors.green,
      ),
    );
  }
}
