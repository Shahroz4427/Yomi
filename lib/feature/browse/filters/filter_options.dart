import 'package:flutter/material.dart';

/// Selected values per filter group, e.g. {'Genre': {'Action', 'Comedy'}}.
typedef FilterSelection = Map<String, Set<String>>;

/// Every filter group and its options, in display order.
const Map<String, List<String>> kFilterOptions = {
  'Genre': [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Fantasy',
    'Romance',
    'Sci-Fi',
    'Slice of Life',
    'Sports',
    'Thriller',
    'Mystery',
    'Horror',
  ],
  'Country': ['Japan', 'China', 'South Korea', 'USA'],
  'Season': ['Winter', 'Spring', 'Summer', 'Fall'],
  'Year': ['2026', '2025', '2024', '2023', '2022', '2021', '2020', 'Older'],
  'Type': ['TV', 'Movie', 'OVA', 'ONA', 'Special'],
  'Status': ['Airing', 'Completed', 'Upcoming'],
  'Language': ['Subbed', 'Dubbed', 'Sub & Dub'],
  'Rating': ['9+', '8+', '7+', '6+', 'Any Rating'],
  'Recently Updated': ['Today', 'This Week', 'This Month', 'This Year'],
};

/// Groups where several options can be selected at once.
/// All other groups allow only one option.
const Set<String> kMultiSelectGroups = {'Genre'};

/// Icon shown next to each group title.
const Map<String, IconData> kFilterIcons = {
  'Genre': Icons.theater_comedy_rounded,
  'Country': Icons.public_rounded,
  'Season': Icons.wb_sunny_rounded,
  'Year': Icons.calendar_month_rounded,
  'Type': Icons.live_tv_rounded,
  'Status': Icons.podcasts_rounded,
  'Language': Icons.translate_rounded,
  'Rating': Icons.star_rounded,
  'Recently Updated': Icons.update_rounded,
};

/// Total number of selected options across all groups.
int countFilters(FilterSelection filters) {
  return filters.values.fold(0, (total, values) => total + values.length);
}

/// Deep copy, so the sheet can edit a draft without touching the real state.
FilterSelection copyFilters(FilterSelection filters) {
  return {
    for (final entry in filters.entries) entry.key: Set<String>.from(entry.value),
  };
}