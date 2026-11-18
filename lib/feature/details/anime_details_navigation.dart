import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/details/screen/anime_details_screen.dart';

/// Opens the details screen of [anime].
///
/// Single entry point so every screen navigates to details the same way.
Future<void> openAnimeDetails(
  BuildContext context, {
  required AnimeItem anime,
  required AnimeRepository repository,
}) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) {
        return AnimeDetailsScreen(anime: anime, repository: repository);
      },
    ),
  );
}
