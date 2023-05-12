import 'package:anilist_movie_flutter/data/models/data.dart';
import 'package:anilist_movie_flutter/data/models/movie.dart';
import 'package:anilist_movie_flutter/screens/query_document_provider.dart';
import 'package:anilist_movie_flutter/widgets/anime_detail.dart';
import 'package:anilist_movie_flutter/widgets/loading_spinner.dart';
import 'package:anilist_movie_flutter/widgets/query_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ListAnime extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ListAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, data, child) {
      final search = data.search;
      final genres = data.genres;
      return QueryWrapper(
        queryString: context.queries.listMovie(),
        dataParser: (json) => PageDataModel.allPageDataFromJson(json),
        variables: {
          'page': 1,
          'perPage': 20,
          'search': search == '' ? null : search,
          'genre': genres.isEmpty ? null : genres,
        },
        contentBuilder: (result, loading, fetchMore) {
          final List<MovieModel> movies = result.movies
              .where((element) => element.coverImage is String)
              .toList();
          final pageInfo = result.page;
          return Expanded(
            child: NotificationListener(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                controller: _scrollController,
                children: [
                  for (var data in movies) ...[
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: AnimeDetail(
                                anime: data,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: data.coverImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                  if (loading) ...[const LoadingSpinner()]
                ],
              ),
              onNotification: (t) {
                if (t is ScrollEndNotification &&
                    pageInfo.hasNextPage == true) {
                  var triggerFetchMoreSize =
                      0.9 * _scrollController.position.maxScrollExtent;

                  if (_scrollController.position.pixels >
                      triggerFetchMoreSize) {
                    var tempPage = pageInfo.currentPage! + 1;
                    FetchMoreOptions opts = FetchMoreOptions(
                      variables: {
                        'page': tempPage,
                      },
                      updateQuery: (previousResultData, fetchMoreResultData) {
                        final List<dynamic> repos = [
                          ...previousResultData!['Page']['media']
                              as List<dynamic>,
                          ...fetchMoreResultData!['Page']['media']
                              as List<dynamic>
                        ];

                        fetchMoreResultData['Page']['media'] = repos;
                        return fetchMoreResultData;
                      },
                    );
                    fetchMore(opts);
                  }
                  return true;
                }
                return false;
              },
            ),
          );
        },
      );
    });
  }
}
