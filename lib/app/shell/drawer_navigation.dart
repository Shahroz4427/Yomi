import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/anime_list/anime_list_navigation.dart';
import 'package:yomi/feature/details/anime_details_navigation.dart';

/// Decides what happens when an item of the side drawer is tapped.
///
/// While the data is static, categories and genres show every anime (the
/// dummy data has no genre field). With the API they can request a filtered
/// list.
class DrawerNavigation {
  const DrawerNavigation({required this.repository, required this.onHome});

  final AnimeRepository repository;

  /// Switches the main screen to its Home tab.
  final VoidCallback onHome;

  // Drawer label -> anime type used to filter the list.
  static const Map<String, String> _typeByLabel = {
    'Movies': 'Movie',
    'TV Series': 'TV',
    'OVAs': 'OVA',
    'ONAs': 'ONA',
    'Specials': 'Special',
  };

  // Items that have no screen yet.
  static const Set<String> _comingSoon = {'W2G', 'Name', 'News', 'Events'};

  void open(BuildContext context, String item) {
    if (item == 'Home') {
      onHome();
    } else if (item == 'Random') {
      _openRandomAnime(context);
    } else if (item == 'Most Popular') {
      _openList(context, item, repository.getAllTimePopular());
    } else if (_typeByLabel.containsKey(item)) {
      final type = _typeByLabel[item];
      final animes = repository.getAllAnime().where((a) => a.type == type);

      _openList(context, item, animes.toList());
    } else if (_comingSoon.contains(item)) {
      showComingSoon(context, item);
    } else {
      // Subbed / Dubbed and every genre.
      _openList(context, item, repository.getAllAnime());
    }
  }

  /// Shown for features that are not built yet.
  static void showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$feature is coming soon')));
  }

  void _openList(BuildContext context, String title, List<AnimeItem> animes) {
    openAnimeList(
      context,
      title: title,
      animes: animes,
      repository: repository,
    );
  }

  void _openRandomAnime(BuildContext context) {
    final animes = repository.getAllAnime();

    if (animes.isEmpty) return;

    openAnimeDetails(
      context,
      anime: animes[Random().nextInt(animes.length)],
      repository: repository,
    );
  }
}
