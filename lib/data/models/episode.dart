/// One playable episode of an anime.
class Episode {
  final int number;
  final String title;

  /// Display text, e.g. "24 min".
  final String duration;

  /// Address of the video stream for this episode.
  final String videoUrl;

  const Episode({
    required this.number,
    required this.title,
    required this.duration,
    required this.videoUrl,
  });
}
