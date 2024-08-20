import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

@immutable
class const CartTotalWidget({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<AppState>(
    builder: (context, model, child) => Text.rich(
      TextSpan(
        text: 'Shipping ${currencyFormatter.format(model.shippingCost)}\n',
        children: [
          TextSpan(text: 'Tax ${currencyFormatter.format(model.totalTax)}\n'),
          TextSpan(
            text: 'Total ${currencyFormatter.format(model.totalCost)}',
            style: const .new(fontSize: 18, fontWeight: .w500),
          ),
        ],
      ),
      style: const .new(height: 1.5, fontSize: 14),
      textAlign: .right,
    ),
  );
}
