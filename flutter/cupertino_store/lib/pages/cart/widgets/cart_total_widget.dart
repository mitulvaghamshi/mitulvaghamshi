import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class CartTotalWidget extends StatelessWidget {
  const CartTotalWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<AppState>(
    builder: (context, model, child) => Text.rich(
      TextSpan(
        text: 'Shipping ${format.format(model.shippingCost)}\n',
        children: [
          TextSpan(text: 'Tax ${format.format(model.totalTax)}\n'),
          TextSpan(
            text: 'Total ${format.format(model.totalCost)}',
            style: const .new(fontSize: 18, fontWeight: .w500),
          ),
        ],
      ),
      style: const .new(height: 1.5, fontSize: 14),
      textAlign: .right,
    ),
  );
}
