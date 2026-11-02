import 'package:flutter/material.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:yomi/model/anime_item.dart';

class TrendingNow extends StatelessWidget {
  const TrendingNow({super.key});

  static const List<AnimeItem> trendingNowAnimes = [
    AnimeItem(
      title: 'Overgeared',
      image: 'assets/images/anime6.jpg',
      rating: 7.6,
      type: 'ONA',
      episodes: '12 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 6 · 6d 2h',
    ),
    AnimeItem(
      title: 'One Piece',
      image: 'assets/images/anime7.jpg',
      rating: 8.7,
      type: 'TV',
      episodes: '10 ep',
      badge: 'PG-13',
      nextEpisode: 'Ep 1181 · 69d 2h',
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
        title: 'Trending Now',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: trendingNowAnimes,
        cardWidth: 150,
        topIcon: Icons.trending_up,
        topIconColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
