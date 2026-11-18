import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_banner.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/anime_list/anime_list_navigation.dart';
import 'package:yomi/feature/details/anime_details_navigation.dart';
import 'package:yomi/feature/home/widget/banner_slider.dart';
import 'package:yomi/feature/home/widget/home_anime_section.dart';
import 'package:yomi/feature/player/video_player_navigation.dart';

/// Home tab: featured banners followed by horizontal anime sections.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.repository});

  final AnimeRepository repository;

  void _openDetails(BuildContext context, AnimeItem anime) {
    openAnimeDetails(context, anime: anime, repository: repository);
  }

  void _openList(BuildContext context, String title, List<AnimeItem> animes) {
    openAnimeList(
      context,
      title: title,
      animes: animes,
      repository: repository,
    );
  }

  // Plays the demo video of the banner's anime.
  void _watchBanner(BuildContext context, AnimeBanner banner) {
    final details = repository.getAnimeDetails(banner.toAnimeItem());

    openVideoPlayer(
      context,
      animeTitle: banner.title,
      posterPath: banner.image,
      episodes: details.episodes,
    );
  }

  // Saving to the user's list needs the API; for now only give feedback.
  void _addBannerToList(BuildContext context, AnimeBanner banner) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${banner.title} added to My List')));
  }

  // One home section; all of them behave the same way.
  Widget _section(
    BuildContext context, {
    required String title,
    required List<AnimeItem> items,
    required IconData icon,
    required Color iconColor,
  }) {
    return HomeAnimeSection(
      title: title,
      items: items,
      icon: icon,
      iconColor: iconColor,
      onViewAll: () => _openList(context, title, items),
      onAnimeTap: (anime) => _openDetails(context, anime),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerSlider(
              banners: repository.getBanners(),
              onWatchNow: (banner) => _watchBanner(context, banner),
              onAddToList: (banner) => _addBannerToList(context, banner),
            ),
            _section(
              context,
              title: 'Currently Airing',
              items: repository.getCurrentlyAiring(),
              icon: Icons.local_fire_department_rounded,
              iconColor: Colors.orange,
            ),
            _section(
              context,
              title: 'Trending Now',
              items: repository.getTrendingNow(),
              icon: Icons.trending_up,
              iconColor: Colors.deepPurpleAccent,
            ),
            _section(
              context,
              title: 'All-Time Popular',
              items: repository.getAllTimePopular(),
              icon: Icons.star,
              iconColor: Colors.amber,
            ),
            _section(
              context,
              title: 'Coming Next Season',
              items: repository.getComingNextSeason(),
              icon: Icons.upcoming,
              iconColor: Colors.green,
            ),
            _section(
              context,
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
