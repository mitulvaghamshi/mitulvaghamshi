import 'package:apis/wiki/search_bar.dart';
import 'package:apis/wiki/search_result.dart';
import 'package:apis/wiki/wikipedia.dart';
import 'package:flutter/cupertino.dart';

@immutable
class WikiScreen extends StatefulWidget {
  const WikiScreen({super.key});

  @override
  WikiScreenState createState() => WikiScreenState();
}

class WikiScreenState extends State<WikiScreen> {
  Iterable<Result> items = [];

  void _search(term) async {
    final response = await Wikipedia.query(term);
    setState(() => items = response.search.results);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(
        largeTitle: Text('Search Wikipedia'),
      ),
      SliverSafeArea(
        minimum: const EdgeInsets.all(16),
        sliver: SliverList.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return SearchBar(onSearch: _search);
            return SearchResult(result: items.elementAt(index - 1));
          },
        ),
      ),
    ]);
  }
}
