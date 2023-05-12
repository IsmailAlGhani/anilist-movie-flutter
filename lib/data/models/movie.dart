class MovieModel {
  MovieModel({
    required this.id,
    required this.title,
    required this.genres,
    required this.episodes,
    required this.season,
    required this.seasonYear,
    required this.bannerImage,
    required this.coverImage,
    required this.status,
    required this.description,
  });

  final int? id;
  final String? title;
  final List<String>? genres;
  final int? episodes;
  final String? season;
  final int? seasonYear;
  final String? bannerImage;
  final String? coverImage;
  final String? status;
  final String? description;

  factory MovieModel.fromJson(Map<String, dynamic> data) {
    return MovieModel(
      id: data['id'],
      title: data['title']['romaji'],
      genres: List<String>.from(data['genres']),
      episodes: data['episodes'],
      season: data['season'],
      seasonYear: data['seasonYear'],
      bannerImage: data['bannerImage'],
      coverImage: data['coverImage']['large'],
      status: data['status'],
      description: data['description'],
    );
  }

  MovieModel.dummy({int id_ = 0})
      : id = id_,
        title = 'Cowboy Bebop',
        genres = ["Action", "Adventure", "Drama", "Sci-Fi"],
        episodes = 26,
        season = 'SPRING',
        seasonYear = 1998,
        bannerImage =
            'https://s4.anilist.co/file/anilistcdn/media/anime/banner/1-OquNCNB6srGe.jpg',
        coverImage =
            'https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx1-CXtrrkMpJ8Zq.png',
        status = 'FINISHED',
        description =
            'Enter a world in the distant future, where Bounty Hunters roam the solar system. Spike and Jet, bounty hunting partners, set out on journeys in an ever struggling effort to win bounty rewards to survive.<br><br>\nWhile traveling, they meet up with other very interesting people. Could Faye, the beautiful and ridiculously poor gambler, Edward, the computer genius, and Ein, the engineered dog be a good addition to the group?';

  @override
  String toString() {
    return '{id: $id, title: $title}';
  }
}

class PageModel {
  PageModel({
    required this.total,
    required this.currentPage,
    required this.lastPage,
    required this.hasNextPage,
    required this.perPage,
  });

  final int? total;
  final int? currentPage;
  final int? lastPage;
  final bool? hasNextPage;
  final int? perPage;

  factory PageModel.fromJson(Map<String, dynamic> data) {
    return PageModel(
      total: data['total'],
      currentPage: data['currentPage'],
      lastPage: data['lastPage'],
      hasNextPage: data['hasNextPage'],
      perPage: data['perPage'],
    );
  }

  PageModel.dummy({int id_ = 0})
      : total = 1000,
        currentPage = 1,
        lastPage = 50,
        hasNextPage = true,
        perPage = 20;

  @override
  String toString() {
    return '{total: $total, currentPage: $currentPage, lastPage: $lastPage, hasNextPage: $hasNextPage, perPage: $perPage}';
  }
}

class PageDataModel {
  final PageModel page;
  final List<MovieModel> movies;

  PageDataModel({
    required this.page,
    required this.movies,
  });

  factory PageDataModel.allPageDataFromJson(Map<String, dynamic> json) {
    if (json['Page'] == null) {
      return PageDataModel(
          page: PageModel.dummy(),
          movies: List<MovieModel>.from([MovieModel.dummy(id_: 0)]));
    }
    Map<String, dynamic> tempPage = json['Page'];
    return PageDataModel(
      page: PageModel.fromJson(tempPage['pageInfo']),
      movies: List<MovieModel>.from(
          tempPage['media'].map((e) => MovieModel.fromJson(e))),
    );
  }
}

class ListGenre {
  final List<String> genres;

  ListGenre({required this.genres});

  factory ListGenre.fromJson(Map<String, dynamic> json) {
    return ListGenre(
      genres: List<String>.from(json['GenreCollection']),
    );
  }
}
