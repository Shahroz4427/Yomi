import 'package:flutter/material.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:yomi/model/anime_item.dart';

class CurrentlyAiring extends StatelessWidget {
  const CurrentlyAiring({super.key});

  static const List<AnimeItem> currentlyAiringAnimes = [
    AnimeItem(
      title: 'Cyberpunk: Edgerunners 2',
      image: 'assets/images/anime1.png',
      rating: 8.4,
      type: 'ONA',
      episodes: '10 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 5 · 4d 2h',
    ),
    AnimeItem(
      title: 'The Apothecary Diaries Season 3',
      image: 'assets/images/anime2.jpg',
      rating: 8.5,
      type: 'TV',
      episodes: '12 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 5 · 5d 2h',
    ),
    AnimeItem(
      title: 'Black Clover Season 2',
      image: 'assets/images/anime3.jpg',
      rating: 8.7,
      type: 'TV',
      episodes: '24 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 5 · 5d 2h',
    ),
    AnimeItem(
      title: 'Reincarnated as a Sword Season 2',
      image: 'assets/images/anime4.png',
      rating: 9.0,
      type: 'TV',
      episodes: '12 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 6 · 2d 4h',
    ),
    AnimeItem(
      title: 'Blue Box Season 2',
      image: 'assets/images/anime5.jpg',
      rating: 8.8,
      type: 'TV',
      episodes: '23 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 8 · 3d 1h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: AnimeCardList(
        title: 'Currently Airing',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: currentlyAiringAnimes,
        cardWidth: 150,
        topIcon: Icons.local_fire_department_rounded,
        topIconColor: Colors.orange,
      ),
    );
  }
}
