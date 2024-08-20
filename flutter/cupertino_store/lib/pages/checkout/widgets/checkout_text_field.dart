import 'package:flutter/cupertino.dart';

@immutable
class const CheckoutTextField({
  required final Widget prefix,
  required final String hint,
  required final TextEditingController controller,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoTextField(
    controller: controller,
    padding: const .all(16),
    placeholder: hint,
    prefix: Padding(padding: const .only(left: 16), child: prefix),
  );
}
