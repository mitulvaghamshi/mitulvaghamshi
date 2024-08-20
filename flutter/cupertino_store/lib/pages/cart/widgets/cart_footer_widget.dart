import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/pages/cart/widgets/cart_total_widget.dart';
import 'package:cupertino_store/pages/checkout/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class CartFooterWidget extends StatelessWidget {
  const CartFooterWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .end,
    crossAxisAlignment: .stretch,
    children: [
      const CartTotalWidget(),
      const SizedBox(height: 16),
      CupertinoButton.filled(
        onPressed: () => _makePayment(context),
        sizeStyle: .small,
        child: const Text('Make Payment'),
      ),
      const SizedBox(height: 16),
      CupertinoButton.tinted(
        onPressed: () => _clearCart(context),
        sizeStyle: .small,
        color: CupertinoColors.destructiveRed,
        child: const Text(
          'Clear Cart',
          style: .new(color: CupertinoColors.destructiveRed),
        ),
      ),
    ],
  );
}

extension on CartFooterWidget {
  Future<void> _makePayment(BuildContext context) =>
      Navigator.of(context) //
          .push(CupertinoPageRoute(builder: (_) => const CheckoutScreen()));

  Future<void> _clearCart(BuildContext context) async => showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Are you sure want to clear?'),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            context.read<AppState>().clearCart();
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
