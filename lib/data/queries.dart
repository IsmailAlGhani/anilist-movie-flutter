class MoviesQueries {
  String listMovie() {
    return """
    query (\$page: Int!,\$perPage: Int!, \$search: String, \$genre: [String]){
      Page (page: \$page, perPage: \$perPage) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media (search: \$search, genre_in: \$genre) {
          id
          title {
            romaji
          }
          description
          genres
          status
          episodes
          season
          seasonYear
          bannerImage
          coverImage {
            extraLarge
            large
            medium
            color
          }
        }
      }
    }
    """;
  }

  String listGenre() {
    return """
    query {
      GenreCollection
    }
    """;
  }
}
