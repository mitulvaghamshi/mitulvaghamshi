import 'package:flutter/material.dart';

@immutable
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onSubmit,
    required this.onClose,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: focusNode,
      controller: controller,
      onSubmitted: (_) => onSubmit(),
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search Google Store',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: IconButton(
          onPressed: onSubmit,
          icon: const Icon(Icons.search),
        ),
        suffixIcon: IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
