import 'package:apis/models/wiki.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';

@immutable
class WikiScreen extends StatefulWidget {
  const WikiScreen({super.key});

  @override
  State<WikiScreen> createState() => _WikiScreenState();
}

class _WikiScreenState extends State<WikiScreen> {
  Iterable<Result> _items = const .empty();

  void _onSearch(String term) async {
    final response = await Wiki.query(term);
    setState(() => _items = response.search.results);
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Wikipedia')),
      SliverToBoxAdapter(
        child: Padding(
          padding: const .all(16),
          child: CupertinoSearchTextField(
            onSubmitted: _onSearch,
            placeholder: 'Search wikipedia...',
          ),
        ),
      ),
      SliverSafeArea(
        minimum: const .all(16),
        sliver: SliverList.builder(
          itemCount: _items.length,
          itemBuilder: (_, index) =>
              _WikiListItem(result: _items.elementAt(index)),
        ),
      ),
    ],
  );
}

@immutable
class _WikiListItem extends StatelessWidget {
  const _WikiListItem({required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) => CupertinoListTile(
    padding: .zero,
    title: Text(result.title),
    subtitle: Html(
      data: result.snippet,
      style: {
        'body': Style(
          margin: .symmetric(vertical: 8),
          maxLines: 3,
          fontSize: .medium,
          fontFamily: 'georgia',
        ),
      },
    ),
  );
}
