import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:wiki_search/models/result.dart';
import 'package:wiki_search/models/search.dart';

@immutable
class WikiApp extends StatefulWidget {
  const WikiApp({super.key});

  @override
  State<WikiApp> createState() => _WikiAppState();
}

class _WikiAppState extends State<WikiApp> {
  Iterable<Result> _items = const .empty();

  Future<void> _onSearch(String term) async {
    final response = await _search(term);
    setState(() => _items = response.results);
  }

  final _cssStyle = {
    'body': Style(
      maxLines: 5,
      fontSize: .medium,
      margin: .symmetric(vertical: 8),
    ),
    'span.searchmatch': Style(
      fontStyle: .italic,
      color: Colors.black,
      backgroundColor: Colors.yellow,
    ),
  };

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Wiki Search')),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .all(16),
          child: CupertinoSearchTextField(
            onSubmitted: _onSearch,
            placeholder: 'Search Wikipedia...',
          ),
        ),
      ),
      SliverList.builder(
        itemCount: _items.length,
        itemBuilder: (_, index) {
          final result = _items.elementAt(index);
          return CupertinoListTile(
            title: Text(result.label),
            subtitle: Html(data: result.snippet, style: _cssStyle),
          );
        },
      ),
    ],
  );
}

extension on _WikiAppState {
  Future<Search> _search(String term) async {
    // DEBUG flag: `--dart-define DEBUG=true`
    // ignore: do_not_use_environment
    if (const bool.fromEnvironment('DEBUG')) {
      final data = await rootBundle.loadString('assets/wiki.json');
      return .fromJson(jsonDecode(data));
    }

    final url = Uri.https('en.wikipedia.org', 'w/api.php', {
      'list': 'search',
      'format': 'json',
      'action': 'query',
      'srsearch': term,
    });

    final res = await http.get(url);
    if (res.statusCode == HttpStatus.ok && res.body.isNotEmpty) {
      return .fromJson(jsonDecode(res.body));
    }

    throw HttpException('[WikiApp]: ${res.reasonPhrase}');
  }
}
