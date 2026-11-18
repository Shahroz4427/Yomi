/// Sort options of the My List screen.
enum MyListSort {
  recentlyUpdated('Recently Updated'),
  recentlyAdded('Recently Added'),
  alphabetical('A-Z'),
  rating('Rating');

  const MyListSort(this.label);

  /// Text shown in the UI.
  final String label;
}
