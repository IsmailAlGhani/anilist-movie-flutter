import 'dart:collection';

import 'package:anilist_movie_flutter/data/models/movie.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  late String _search = '';
  late List<String> _genres = [];
  late final List<MovieModel> _movies = [];
  PageModel _pageInfo = PageModel(
      total: 1000,
      currentPage: 1,
      lastPage: 50,
      hasNextPage: true,
      perPage: 20);

  int get genreCount {
    return _genres.length;
  }

  String get search {
    return _search;
  }

  PageModel get pageInfo {
    return _pageInfo;
  }

  UnmodifiableListView<String> get genres {
    return UnmodifiableListView(_genres);
  }

  UnmodifiableListView<MovieModel> get movies {
    return UnmodifiableListView(_movies);
  }

  void updateSearch(String type) {
    _search = type;
    notifyListeners();
  }

  void updateGenre(List<String> data) {
    _genres = data;
    notifyListeners();
  }

  void updatePageInfo(PageModel data) {
    _pageInfo = data;
    notifyListeners();
  }

  void updateMovies(List<MovieModel> data) {
    _movies.addAll(data);
    notifyListeners();
  }
}
