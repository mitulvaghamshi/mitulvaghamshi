import 'package:istore/models/app_state.dart';
import 'package:istore/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

@immutable
class FinalCostWidget extends StatelessWidget {
  const FinalCostWidget({
    super.key,
    required this.model,
    required this.format,
  });

  final AppState model;
  final NumberFormat format;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            'Shipping ${format.format(model.shippingCost)}',
            style: Styles.productItemPrice,
          ),
          const SizedBox(height: 6),
          Text(
            'Tax ${format.format(model.totalTax)}',
            style: Styles.productItemPrice,
          ),
          const SizedBox(height: 6),
          Text(
            'Total ${format.format(model.totalCost)}',
            style: Styles.productRowTotal,
          ),
          const SizedBox(height: 10),
        ])
      ]),
    );
  }
}
