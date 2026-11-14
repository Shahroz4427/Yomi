import 'package:flutter/material.dart';
import 'package:yomi/core/layout/bottom_bar.dart';
import 'package:yomi/core/layout/side_drawer.dart';
import 'package:yomi/core/layout/top_bar.dart';
import 'package:yomi/feature/browse/screen/browse_screen.dart';
import 'package:yomi/feature/home/screen/home_screen.dart';
import 'package:yomi/model/anime_item.dart';

class MainScreen extends StatefulWidget {
  final List<AnimeItem> animeList;

  const MainScreen({
    super.key,
    this.animeList = const [],
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final screens = [
      const Home(),
      const BrowseAnimeScreen(),
      const Center(child: Text('Top Anime')),
      const Center(child: Text('Schedule')),
      const Center(child: Text('My List')),
    ];

    return Scaffold(
      appBar: const TopBar(),
      drawer: const SideDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}
