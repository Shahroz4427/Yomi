import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/anime_list/screen/anime_list_screen.dart';

/// Opens the full list screen for [animes].
Future<void> openAnimeList(
  BuildContext context, {
  required String title,
  required List<AnimeItem> animes,
  required AnimeRepository repository,
}) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) {
        return AnimeListScreen(
          title: title,
          animes: animes,
          repository: repository,
        );
      },
    ),
  );
}
