import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

@immutable
interface class Wikipedia {
  static Future<Query> query(final term) async {
    if (kDebugMode) {
      final data = await rootBundle.loadString('assets/wiki.json');
      return Query.fromJson(jsonDecode(data));
    }
    final url = Uri.https('en.wikipedia.org', 'w/api.php', {
      'list': 'search',
      'format': 'json',
      'action': 'query',
      'srsearch': term,
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Query.fromJson(jsonDecode(response.body));
    }
    throw '[Wikipedia]: Request failed: ${response.reasonPhrase}, URL: $url';
  }
}

@immutable
class Query {
  const Query({required this.search});

  factory Query.fromJson(final Map<String, dynamic> json) {
    if (json case {'query': final Map<String, dynamic> query}) {
      return Query(search: Search.fromJson(query));
    }
    throw '[Query]: Invalid Json data.';
  }

  final Search search;
}

@immutable
class Search {
  const Search({required this.results});

  factory Search.fromJson(final Map<String, dynamic> json) {
    if (json case {'search': final List<dynamic> search}) {
      final list = List<Map<String, dynamic>>.from(search);
      return Search(results: list.map(Result.fromJson));
    }
    throw '[Search]: Invalid Json data.';
  }

  final Iterable<Result> results;
}

@immutable
class Result {
  const Result({required this.title, required this.snippet});

  factory Result.fromJson(final Map<String, dynamic> json) {
    if (json case {'title': final title, 'snippet': final snippet}) {
      return Result(title: title, snippet: snippet);
    }
    throw '[Result]: Invalid Json data.';
  }

  final String title;
  final String snippet;
}
