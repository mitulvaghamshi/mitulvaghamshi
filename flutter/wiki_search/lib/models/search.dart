import 'package:flutter/cupertino.dart';
import 'package:wiki_search/models/result.dart';

@immutable
class Search {
  const Search({required this.results});

  factory Search.fromJson(Object? json) {
    if (json case {'query': {'search': final Iterable<dynamic> items}}) {
      return .new(results: items.map(Result.fromJson));
    }

    if (json case {
      'error': {'code': final String code, 'info': final String info},
    }) {
      if (code == 'missingparam') {
        return .new(
          results: [
            .error(
              code: 'WIKIPEDIA SEARCH ERROR!',
              info: 'Please specify what you want to search for.',
            ),
          ],
        );
      }
      return .new(
        results: [.error(code: code, info: info)],
      );
    }

    throw FormatException('[Search]: Invalid JSON, $json');
  }

  final Iterable<Result> results;
}
