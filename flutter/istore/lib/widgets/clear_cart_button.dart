import 'package:istore/models/app_state.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ClearCartButton extends StatelessWidget {
  const ClearCartButton({super.key, required this.model});

  final AppState model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CupertinoButton.filled(
        onPressed: model.certItems.isEmpty ? null : () => _clear(context),
        disabledColor: CupertinoColors.inactiveGray,
        child: const Text('Clear Cart'),
      ),
    );
  }
}

extension on ClearCartButton {
  Future<void> _clear(context) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Are you sure want to clear?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              model.clearCart();
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: const Text('Yes'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            isDefaultAction: true,
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
