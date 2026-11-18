import 'package:flutter/material.dart';
import 'package:yomi/app/shell/bottom_bar.dart';
import 'package:yomi/app/shell/drawer_navigation.dart';
import 'package:yomi/app/shell/side_drawer/side_drawer.dart';
import 'package:yomi/app/shell/top_bar.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/data/repositories/my_list_repository.dart';
import 'package:yomi/data/repositories/schedule_repository.dart';
import 'package:yomi/feature/browse/screen/browse_screen.dart';
import 'package:yomi/feature/home/screen/home_screen.dart';
import 'package:yomi/feature/mylist/screen/my_list_screen.dart';
import 'package:yomi/feature/schedule/screen/schedule_screen.dart';
import 'package:yomi/feature/top/screen/top_screen.dart';

/// App shell: top bar, side drawer, bottom navigation and the five tabs.
class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.animeRepository,
    required this.scheduleRepository,
    required this.myListRepository,
  });

  final AnimeRepository animeRepository;
  final ScheduleRepository scheduleRepository;
  final MyListRepository myListRepository;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Order must match the destinations in BottomBar.
  late final List<Widget> _screens = [
    HomeScreen(repository: widget.animeRepository),
    BrowseScreen(repository: widget.animeRepository),
    TopScreen(repository: widget.animeRepository),
    ScheduleScreen(
      repository: widget.scheduleRepository,
      animeRepository: widget.animeRepository,
    ),
    MyListScreen(
      repository: widget.myListRepository,
      animeRepository: widget.animeRepository,
    ),
  ];

  late final DrawerNavigation _drawerNavigation = DrawerNavigation(
    repository: widget.animeRepository,
    onHome: () => _onItemSelected(0),
  );

  void _onItemSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(animeRepository: widget.animeRepository),
      drawer: SideDrawer(
        onItemSelected: (item) => _drawerNavigation.open(context, item),
        onCommunityTap: () {
          DrawerNavigation.showComingSoon(context, 'Community');
        },
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}
