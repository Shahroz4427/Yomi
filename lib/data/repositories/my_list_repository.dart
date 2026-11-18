import 'package:yomi/data/models/my_list_entry.dart';

/// Where the UI gets the user's saved anime list from.
abstract interface class MyListRepository {
  List<MyListEntry> getMyList();
}
