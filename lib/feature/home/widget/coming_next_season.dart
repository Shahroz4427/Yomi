import 'package:flutter/material.dart';
import 'package:yomi/feature/home/widget/anime_card_list.dart';
import 'package:yomi/model/anime_item.dart';

class ComingNextSeason extends StatelessWidget {
  const ComingNextSeason({super.key});

  static const List<AnimeItem> comingNextSeasonAnimes = [
    AnimeItem(
      title: 'MASHLE: MAGIC AND MUSCLES The Tri-Magicathlon Divine Visionary Final Exam Arc',
      image: 'assets/images/anime15.jpg',
      rating: 0,
      type: 'TV',
      episodes: 'ep 1-86d 20h',
      badge: 'PG-13',
      // nextEpisode: 'Ep 6 · 6d 2h',
    ),
    AnimeItem(
      title: 'Shangri-La Frontier Season 3',
      image: 'assets/images/anime16.jpg',
      rating: 0,
      type: 'TV',
      episodes: 'ep 1-66d 1h',
      badge: 'PG-13',
      // nextEpisode: 'Ep 1181 · 69d 2h',
    ),
    AnimeItem(
      title: 'The Guy She Was Interested In Wasnt a Guy At All',
      image: 'assets/images/anime17.jpg',
      rating: 0,
      type: 'TV',
      episodes: '24 ep',
      badge: 'PG-13',
      // nextEpisode: 'Ep 5 · 5d 2h',
    ),
    AnimeItem(
      title: 'Sekai Saikou no Ansatsusha, Isekai Kizoku ni Tensei suru 2nd Season',
      image: 'assets/images/anime18.png',
      rating: 0,
      type: 'TV',
      episodes: '37 ep',
      badge: 'PG-14+',
      // nextEpisode: 'Ep 6 · 2d 4h',
    ),
    AnimeItem(
      title: 'THE ONE PIECE',
      image: 'assets/images/anime19.jpg',
      rating: 0,
      type: 'TV',
      episodes: '13',
      badge: 'PG-13',
      // nextEpisode: 'Ep 8 · 3d 1h',
    ),
    AnimeItem(
      title: 'SAKAMOTO DAYS Season 2',
      image: 'assets/images/anime20.jpg',
      rating: 0,
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
        title: 'Coming Next Season',
        onViewAll: () {},
        onAnimeTap: (anime) {},
        items: comingNextSeasonAnimes,
        cardWidth: 150,
        topIcon: Icons.upcoming,
        topIconColor: Colors.green,
      ),
    );
  }
}
