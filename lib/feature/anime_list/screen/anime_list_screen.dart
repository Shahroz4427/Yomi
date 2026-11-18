import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/details/anime_details_navigation.dart';
import 'package:yomi/shared/widgets/anime_grid.dart';

/// Full list of anime for a section ("View all") or a drawer category.
class AnimeListScreen extends StatelessWidget {
  const AnimeListScreen({
    super.key,
    required this.title,
    required this.animes,
    required this.repository,
  });

  final String title;
  final List<AnimeItem> animes;
  final AnimeRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: AnimeGrid(
          animes: animes,
          onAnimeTap: (anime) {
            openAnimeDetails(context, anime: anime, repository: repository);
          },
        ),
      ),
    );
  }
}
