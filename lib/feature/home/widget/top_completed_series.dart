import 'package:flutter/material.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:yomi/model/anime_item.dart';

class TopCompletedSeries extends StatelessWidget {
  const TopCompletedSeries({super.key});

  static const List<AnimeItem> topCompletedSeriesAnimes = [
    AnimeItem(
      title: 'Frieren: Beyond Journey’s End',
      image: 'assets/images/anime21.jpg',
      rating: 9.1,
      type: 'TV',
      episodes: '28 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 6 · 6d 2h',
    ),
    AnimeItem(
      title: 'Gintama: THE VERY FINAL',
      image: 'assets/images/anime22.jpg',
      rating: 9.0,
      type: 'Movie',
      episodes: 'Movie',
      badge: 'PG-13',
      // nextEpisode: 'Ep 1181 · 69d 2h',
    ),
    AnimeItem(
      title: 'Gintama Season 3',
      image: 'assets/images/anime23.jpg',
      rating: 9.0,
      type: 'TV',
      episodes: '51 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 5 · 5d 2h',
    ),
    AnimeItem(
      title: 'Re:ZERO -Starting Life in Another World- Season 4',
      image: 'assets/images/anime24.jpg',
      rating: 9.0,
      type: 'TV',
      episodes: '19 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 6 · 2d 4h',
    ),
    AnimeItem(
      title: 'Chainsaw Man – The Movie: Reze Arc',
      image: 'assets/images/anime25.png',
      rating: 9.0,
      type: 'Movie',
      episodes: 'Movie 1 ep',
      badge: 'R14+',
      // nextEpisode: 'Ep 8 · 3d 1h',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'Top Completed Series',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: topCompletedSeriesAnimes,
        cardWidth: 150,
        topIcon: Icons.check,
        topIconColor: Colors.blue,
      ),
    );
  }
}
