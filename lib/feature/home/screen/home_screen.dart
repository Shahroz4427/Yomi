import 'package:flutter/material.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/home/widget/banner_slider.dart';
import 'package:yomi/feature/home/widget/home_anime_section.dart';

/// Home tab: featured banners followed by horizontal anime sections.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.repository});

  final AnimeRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerSlider(banners: repository.getBanners()),
            HomeAnimeSection(
              title: 'Currently Airing',
              items: repository.getCurrentlyAiring(),
              icon: Icons.local_fire_department_rounded,
              iconColor: Colors.orange,
            ),
            HomeAnimeSection(
              title: 'Trending Now',
              items: repository.getTrendingNow(),
              icon: Icons.trending_up,
              iconColor: Colors.deepPurpleAccent,
            ),
            HomeAnimeSection(
              title: 'All-Time Popular',
              items: repository.getAllTimePopular(),
              icon: Icons.star,
              iconColor: Colors.amber,
            ),
            HomeAnimeSection(
              title: 'Coming Next Season',
              items: repository.getComingNextSeason(),
              icon: Icons.upcoming,
              iconColor: Colors.green,
            ),
            HomeAnimeSection(
              title: 'Top Completed Series',
              items: repository.getTopCompletedSeries(),
              icon: Icons.check,
              iconColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
