import 'package:flutter/material.dart';
import 'package:yomi/app/shell/main_screen.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/data/repositories/my_list_repository.dart';
import 'package:yomi/data/repositories/schedule_repository.dart';
import 'package:yomi/feature/splash/screen/splash_screen.dart';

/// Root widget: theme and the first screen.
class YomiApp extends StatelessWidget {
  const YomiApp({
    super.key,
    required this.animeRepository,
    required this.scheduleRepository,
    required this.myListRepository,
  });

  final AnimeRepository animeRepository;
  final ScheduleRepository scheduleRepository;
  final MyListRepository myListRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yomi',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: SplashScreen(
        nextScreen: MainScreen(
          animeRepository: animeRepository,
          scheduleRepository: scheduleRepository,
          myListRepository: myListRepository,
        ),
      ),
    );
  }
}
