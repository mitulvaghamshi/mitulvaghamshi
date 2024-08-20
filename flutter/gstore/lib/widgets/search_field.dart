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

  void _onClear() {
    _controller.clear();
    widget.onSubmit('');
  }

  void _onSubmit(String value) {
    _focusNode.unfocus();
    widget.onSubmit(_controller.text);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    autofocus: true,
    focusNode: _focusNode,
    controller: _controller,
    onSubmitted: _onSubmit,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      hintText: 'Search Google Store',
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: IconButton(
        onPressed: _onClear,
        icon: const Icon(Icons.search),
      ),
      suffixIcon: IconButton(
        onPressed: widget.onClose,
        icon: const Icon(Icons.close),
      ),
    ),
  );
}
