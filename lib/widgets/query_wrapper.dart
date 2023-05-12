import 'package:anilist_movie_flutter/data/models/error.dart';
import 'package:anilist_movie_flutter/widgets/error_widget.dart';
import 'package:anilist_movie_flutter/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryWrapper<T> extends StatelessWidget {
  const QueryWrapper({
    Key? key,
    required this.queryString,
    required this.contentBuilder,
    required this.dataParser,
    this.variables,
    this.useFetchMore,
  }) : super(key: key);
  final Map<String, dynamic>? variables;
  final String queryString;
  final Widget Function(T data, bool loading, FetchMore fetchMore)
      contentBuilder;
  final T Function(Map<String, dynamic> data) dataParser;
  final bool? useFetchMore;
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(queryString),
        variables: variables ?? const {},
        parserFn: dataParser,
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (useFetchMore == false && result.isLoading) {
          return const LoadingSpinner();
        }

        if (result.hasException) {
          return AppErrorWidget(
            error: ErrorModel.fromString(
              result.exception.toString(),
            ),
          );
        }

        return contentBuilder(result.parserFn(result.data ?? {}) as T,
            result.isLoading, fetchMore!);
      },
    );
  }
}
