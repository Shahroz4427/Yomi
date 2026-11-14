import 'package:flutter/material.dart';
import 'package:yomi/feature/home/widget/all_time_popular.dart';
import 'package:yomi/feature/home/widget/banner_slider.dart';
import 'package:yomi/feature/home/widget/coming_next_season.dart';
import 'package:yomi/feature/home/widget/currently_airing.dart';
import 'package:yomi/feature/home/widget/top_completed_series.dart';
import 'package:yomi/feature/home/widget/trending_now.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerSlider(),
            CurrentlyAiring(),
            TrendingNow(),
            AllTimePopular(),
            ComingNextSeason(),
            TopCompletedSeries(),
          ],
        ),
      ),
    );
  }
}
