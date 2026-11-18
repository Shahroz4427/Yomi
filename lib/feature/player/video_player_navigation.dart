import 'package:flutter/material.dart';
import 'package:yomi/data/models/episode.dart';
import 'package:yomi/feature/player/screen/video_player_screen.dart';

/// Opens the video player on [episodes][initialIndex].
Future<void> openVideoPlayer(
  BuildContext context, {
  required String animeTitle,
  required String posterPath,
  required List<Episode> episodes,
  int initialIndex = 0,
}) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) {
        return VideoPlayerScreen(
          animeTitle: animeTitle,
          posterPath: posterPath,
          episodes: episodes,
          initialIndex: initialIndex,
        );
      },
    ),
  );
}
