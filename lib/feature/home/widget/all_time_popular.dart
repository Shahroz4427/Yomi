import 'package:flutter/material.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:yomi/model/anime_item.dart';

class AllTimePopular extends StatelessWidget {
  const AllTimePopular({super.key});

  static const List<AnimeItem> allTimePopularAnimes = [
    AnimeItem(
      title: 'Attack on Titan',
      image: 'assets/images/anime9.jpg',
      rating: 8.5,
      type: 'TV',
      episodes: '25 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 6 · 6d 2h',
    ),
    AnimeItem(
      title: 'Demon Slayer',
      image: 'assets/images/anime10.jpg',
      rating: 8.2,
      type: 'TV',
      episodes: '26 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 1181 · 69d 2h',
    ),
    AnimeItem(
      title: 'JUJUTSU KAISEN',
      image: 'assets/images/anime11.jpg',
      rating: 8.4,
      type: 'TV',
      episodes: '24 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 5 · 5d 2h',
    ),
    AnimeItem(
      title: 'Death Note',
      image: 'assets/images/anime12.jpg',
      rating: 8.4,
      type: 'TV',
      episodes: '37 ep',
      badge: 'PG-14+',
      // nextEpisode: 'Ep 6 · 2d 4h',
    ),
    AnimeItem(
      title: 'My Hero Academia',
      image: 'assets/images/anime5.jpg',
      rating: 7.6,
      type: 'TV',
      episodes: '13',
      badge: 'PG-13',
      // nextEpisode: 'Ep 8 · 3d 1h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'All-Time Popular',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: allTimePopularAnimes,
        cardWidth: 150,
        topIcon: Icons.star,
        topIconColor: Colors.amber,
      ),
    );
  }
}
