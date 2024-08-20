import 'package:flutter/cupertino.dart';
import 'package:wiki_search/models/result.dart';

@immutable
class const Search({required final Iterable<Result> results}) {
  factory fromJson(Object? json) {
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
    throw Exception('[$Search]: ${StackTrace.current}');
  }
}
