import 'package:flutter/material.dart';

@immutable
class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onSubmit, required this.onClose});

  final ValueChanged<String> onSubmit;
  final VoidCallback onClose;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final _controller = TextEditingController();
  late final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: _focusNode,
      controller: _controller,
      onSubmitted: (_) {
        _focusNode.unfocus();
        widget.onSubmit(_controller.text);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search Google Store',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: IconButton(
          onPressed: () {
            _controller.clear();
            widget.onSubmit('');
          },
          icon: const Icon(Icons.search),
        ),
        suffixIcon: IconButton(
          onPressed: widget.onClose,
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
