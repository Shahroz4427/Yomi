import 'package:flutter/material.dart';
import 'package:yomi/core/constants/app_assets.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/auth/screen/login_screen.dart';
import 'package:yomi/feature/search/screen/search_screen.dart';

/// App bar with the menu button, logo, search and login.
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.animeRepository});

  final AnimeRepository animeRepository;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _openSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(repository: animeRepository),
      ),
    );
  }

  void _openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu),
          tooltip: 'Open menu',
        ),
      ),
      title: Image.asset(AppAssets.logo, height: 50, fit: BoxFit.contain),
      centerTitle: false,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => _openSearch(context),
          icon: const Icon(Icons.search),
          tooltip: 'Search anime',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, left: 4),
          child: Center(
            child: SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () => _openLogin(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
