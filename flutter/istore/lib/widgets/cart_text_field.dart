import 'package:istore/utils/styles.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CartTextField extends StatelessWidget {
  const CartTextField({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.controller,
  });

  final IconData icon;
  final String placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CupertinoTextField(
        autocorrect: false,
        controller: controller,
        placeholder: placeholder,
        decoration: Styles.boxDecoration,
        textCapitalization: TextCapitalization.words,
        clearButtonMode: OverlayVisibilityMode.editing,
        prefix: Icon(icon, size: 28, color: CupertinoColors.systemGrey),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      ),
    );
  }
}
