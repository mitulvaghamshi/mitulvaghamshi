import 'package:apis/common/repo.dart';
import 'package:flutter/cupertino.dart';

@immutable
class TabPageBuilder<T> extends StatelessWidget {
  const TabPageBuilder({
    super.key,
    required this.path,
    required this.factory,
    required this.builder,
  });

  final String path;
  final T Function(Map<String, dynamic> json) factory;
  final Widget Function(Iterable<T> items) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Repo<T>>(
      future: Repo.get<T>(path, factory),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return builder(snapshot.data!.items);
      },
    );
  }
}
