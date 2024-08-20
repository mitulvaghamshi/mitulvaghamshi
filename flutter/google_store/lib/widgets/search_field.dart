import 'package:flutter/material.dart';

@immutable
class SearchField extends StatelessWidget {
  const SearchField({required this.onSubmit, required this.onClose, super.key});

  final ValueChanged<String> onSubmit;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => TextField(
    autofocus: true,
    onSubmitted: onSubmit,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: .circular(32)),
      hintText: 'Search Products...',
      prefixIcon: const Icon(Icons.search),
      suffixIcon: IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
    ),
  );
}
