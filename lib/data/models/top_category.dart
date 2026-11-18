/// Ranking options on the Top screen.
enum TopCategory {
  mostPopular('Most Popular'),
  topRated('Top Rated'),
  trending('Trending'),
  topMovies('Top Movies'),
  topTv('Top TV');

  const TopCategory(this.label);

  /// Text shown in the UI.
  final String label;
}
