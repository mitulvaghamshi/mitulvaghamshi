import 'package:flutter/cupertino.dart';

@immutable
class CheckoutTextField extends StatelessWidget {
  const CheckoutTextField({
    required this.prefix,
    required this.hint,
    required this.controller,
    super.key,
  });

  final Widget prefix;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => CupertinoTextField(
    controller: controller,
    padding: const .all(16),
    placeholder: hint,
    prefix: Padding(padding: const .only(left: 16), child: prefix),
  );
}
