import 'package:flutter/material.dart';
import 'package:yomi/app/yomi_app.dart';
import 'package:yomi/data/repositories/static/static_anime_repository.dart';
import 'package:yomi/data/repositories/static/static_my_list_repository.dart';
import 'package:yomi/data/repositories/static/static_schedule_repository.dart';

/// Composition root: the only place that decides which data source the app
/// uses. To switch to the REST API, pass API-backed repositories here.
void main() {
  runApp(
    const YomiApp(
      animeRepository: StaticAnimeRepository(),
      scheduleRepository: StaticScheduleRepository(),
      myListRepository: StaticMyListRepository(),
    ),
  );
}
