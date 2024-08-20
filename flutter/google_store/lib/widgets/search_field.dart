import 'package:flutter/material.dart';

@immutable
class const SearchField({
  required final ValueChanged<String> onSubmit,
  required final VoidCallback onClose,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TextField(
    autofocus: true,
    onSubmitted: onSubmit,
    style: const .new(color: Colors.black),
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: .circular(32)),
      hintText: 'Search Products...',
      prefixIcon: const Icon(Icons.search),
      suffixIcon: IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
    ),
  );
}
