import 'package:yomi/data/models/anime_item.dart';

/// A featured banner shown in the home page slider.
class AnimeBanner {
  final String image;
  final String title;
  final String subtitle;
  final String description;

  const AnimeBanner({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  /// Minimal [AnimeItem] for opening details / playback from a banner.
  ///
  /// Temporary: once the API exists, a banner will reference a real anime id.
  AnimeItem toAnimeItem() {
    return AnimeItem(
      title: title,
      image: image,
      rating: 0,
      type: 'TV',
      episodes: '12 ep',
    );
  }
}
