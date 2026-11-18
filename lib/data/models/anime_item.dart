/// A single anime as shown on cards and lists.
///
/// Plain immutable data class. Keep the field names aligned with the API
/// response when REST integration starts (a `fromJson` factory can be added
/// here without touching any widget).
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
