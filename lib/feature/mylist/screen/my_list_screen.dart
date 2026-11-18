import 'package:flutter/material.dart';
import 'package:yomi/data/models/my_list_entry.dart';
import 'package:yomi/data/repositories/my_list_repository.dart';
import 'package:yomi/feature/mylist/my_list_sort.dart';
import 'package:yomi/feature/mylist/widget/my_list_entries.dart';
import 'package:yomi/feature/mylist/widget/my_list_filter_bar.dart';
import 'package:yomi/feature/mylist/widget/my_list_header.dart';
import 'package:yomi/feature/mylist/widget/my_list_options_sheet.dart';
import 'package:yomi/feature/mylist/widget/my_list_search_sheet.dart';
import 'package:yomi/feature/mylist/widget/my_list_section_header.dart';
import 'package:yomi/feature/mylist/widget/my_list_stats.dart';

/// My List tab: statistics, status filter, sort and the saved anime.
class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key, required this.repository});

  final MyListRepository repository;

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  late final List<MyListEntry> _entries = widget.repository.getMyList();

  // null means "All".
  MyListStatus? _selectedStatus;
  MyListSort _selectedSort = MyListSort.recentlyUpdated;
  String _searchQuery = '';

  /// Entries after applying the status filter, search text and sort order.
  List<MyListEntry> get _visibleEntries {
    final query = _searchQuery.toLowerCase();

    final result = _entries.where((entry) {
      final matchesStatus =
          _selectedStatus == null || entry.status == _selectedStatus;
      final matchesSearch = entry.anime.title.toLowerCase().contains(query);

      return matchesStatus && matchesSearch;
    }).toList();

    switch (_selectedSort) {
      case MyListSort.alphabetical:
        result.sort((a, b) => a.anime.title.compareTo(b.anime.title));
      case MyListSort.rating:
        result.sort((a, b) => b.anime.rating.compareTo(a.anime.rating));
      case MyListSort.recentlyUpdated:
      case MyListSort.recentlyAdded:
        // Keep the original order until the API provides timestamps.
        break;
    }

    return result;
  }

  int _countOf(MyListStatus status) {
    return _entries.where((entry) => entry.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    final visibleEntries = _visibleEntries;

    return SafeArea(
      child: Column(
        children: [
          MyListHeader(
            onSearchTap: () => showMyListSearchSheet(
              context: context,
              onChanged: (query) => setState(() => _searchQuery = query),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                MyListStats(
                  watching: _countOf(MyListStatus.watching),
                  planToWatch: _countOf(MyListStatus.planToWatch),
                  completed: _countOf(MyListStatus.completed),
                ),
                const SizedBox(height: 24),
                MyListFilterBar(
                  selected: _selectedStatus,
                  onSelected: (status) {
                    setState(() => _selectedStatus = status);
                  },
                ),
                const SizedBox(height: 20),
                MyListSectionHeader(
                  title: _selectedStatus?.label ?? 'All Anime',
                  count: visibleEntries.length,
                  selectedSort: _selectedSort,
                  onSortSelected: (sort) {
                    setState(() => _selectedSort = sort);
                  },
                ),
                const SizedBox(height: 12),
                MyListEntries(
                  entries: visibleEntries,
                  onOptionsTap: () => showMyListOptionsSheet(context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
