import 'package:apis/wiki/wikipedia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';

@immutable
class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) {
    final style = CupertinoTheme.of(context).textTheme.textStyle;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(result.title, style: style),
        Html(data: result.snippet, style: {
          'body': Style(
            fontSize: FontSize.medium,
            color: style.color?.withOpacity(0.6),
            margin: Margins.symmetric(vertical: 10),
          ),
        }),
      ]),
    );
  }
}
