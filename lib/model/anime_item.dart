class AnimeItem {
  final String title;
  final String image;
  final double rating;
  final String type;
  final String episodes;
  final String? badge;
  final String? nextEpisode;

  const AnimeItem({
    required this.title,
    required this.image,
    required this.rating,
    required this.type,
    required this.episodes,
    this.badge,
    this.nextEpisode,
  });
}