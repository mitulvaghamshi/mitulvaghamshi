import 'package:flutter/cupertino.dart';

@immutable
class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CupertinoTextField(
        onSubmitted: onSearch,
        placeholder: 'Search Wikipedia...',
        clearButtonMode: OverlayVisibilityMode.always,
      ),
    );
  }
}
