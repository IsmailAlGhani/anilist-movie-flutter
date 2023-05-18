import 'dart:collection';

import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  late String _search = '';
  late List<String> _genres = [];

  int get genreCount {
    return _genres.length;
  }

  String get search {
    return _search;
  }

  UnmodifiableListView<String> get genres {
    return UnmodifiableListView(_genres);
  }

  void updateSearch(String type) {
    _search = type;
    notifyListeners();
  }

  void updateGenre(List<String> data) {
    _genres = data;
    notifyListeners();
  }
}
