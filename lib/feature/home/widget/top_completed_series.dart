import 'package:yomi/data/anime_data.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:flutter/material.dart';

class TopCompletedSeries extends StatelessWidget {
  const TopCompletedSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'Top Completed Series',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: AnimeData.topCompletedSeriesAnimes,
        cardWidth: 150,
        topIcon: Icons.check,
        topIconColor: Colors.blue,
      ),
    );
  }
}
