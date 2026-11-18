/// Sorting / grouping options on the Browse screen.
enum BrowseCategory {
  mostPopular('Most Popular'),
  trendingNow('Trending Now'),
  highestRated('Highest Rated'),
  newestFirst('Newest First'),
  mostEpisodes('Most Episodes');

  const BrowseCategory(this.label);

  /// Text shown in the UI.
  final String label;
}
