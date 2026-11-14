import 'package:flutter/material.dart';
import 'package:yomi/data/anime_data.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';

class CurrentlyAiring extends StatelessWidget {
  const CurrentlyAiring({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'Currently Airing',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: AnimeData.currentlyAiringAnimes,
        cardWidth: 150,
        topIcon: Icons.local_fire_department_rounded,
        topIconColor: Colors.orange,
      ),
    );
  }
}
