import 'package:yomi/feature/home/widget/currently_airing.dart';
import 'package:yomi/feature/home/widget/all_time_popular.dart';
import 'package:yomi/feature/home/widget/banner_slider.dart';
import 'package:yomi/feature/home/widget/trending_now.dart';
import 'package:yomi/core/layout/side_drawer.dart';
import 'package:yomi/core/layout/bottom_bar.dart';
import 'package:yomi/core/layout/top_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerSlider(),
            CurrentlyAiring(),
            TrendingNow(),
            AllTimePopular(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
