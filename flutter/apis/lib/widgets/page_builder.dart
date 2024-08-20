import 'package:apis/api/repo.dart';
import 'package:flutter/cupertino.dart';

@immutable
class PageBuilder<T> extends StatelessWidget {
  const PageBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  final Future<Repo<T>> future;
  final Widget Function(Iterable<T> items) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Repo<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) return builder(snapshot.data!.items);
        if (snapshot.hasError) return Text(snapshot.error.toString());
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }
}
