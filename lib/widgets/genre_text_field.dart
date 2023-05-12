import 'package:anilist_movie_flutter/constants.dart';
import 'package:anilist_movie_flutter/data/models/data.dart';
import 'package:anilist_movie_flutter/data/models/movie.dart';
import 'package:anilist_movie_flutter/screens/query_document_provider.dart';
import 'package:anilist_movie_flutter/widgets/query_wrapper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreTextField extends StatelessWidget {
  const GenreTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QueryWrapper(
      queryString: context.queries.listGenre(),
      dataParser: (json) => ListGenre.fromJson(json),
      useFetchMore: false,
      contentBuilder: (data, loading, fetchMore) {
        return DropdownSearch<String>.multiSelection(
          items: data.genres,
          popupProps: const PopupPropsMultiSelection.menu(
            showSelectedItems: true,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: kTextFieldDecoration.copyWith(
                hintText: 'Search your favorite genre'),
          ),
          onChanged: (data) => context.read<Data>().updateGenre(data),
          selectedItems: context.watch<Data>().genres,
        );
      },
    );
  }
}
