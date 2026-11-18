import 'package:flutter/material.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/details/anime_details_navigation.dart';
import 'package:yomi/shared/widgets/anime_grid.dart';

/// Anime matching [query] as a grid; tapping one opens its details.
class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.query,
    required this.repository,
  });

  final String query;
  final AnimeRepository repository;

  @override
  Widget build(BuildContext context) {
    final results = repository.searchAnime(query);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: AnimeGrid(
        animes: results,
        emptyMessage: 'No results for "$query"',
        onAnimeTap: (anime) {
          openAnimeDetails(context, anime: anime, repository: repository);
        },
      ),
    );
  }
}
