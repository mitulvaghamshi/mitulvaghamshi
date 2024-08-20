import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:istore/models/app_state.dart';
import 'package:istore/models/product.dart';
import 'package:istore/utils/styles.dart';
import 'package:provider/provider.dart';

@immutable
class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppState>(context);
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(largeTitle: const Text('Shopping Cart')),
      SliverSafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        sliver: SliverList.builder(
          itemCount: model.certItems.length,
          itemBuilder: (_, index) => _CartItem(
            product: model //
                .getProductBy(model.certItems.keys.elementAt(index)),
            quantity: model.certItems.values.elementAt(index),
          ),
        ),
      ),
      SliverSafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.list(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _TotalCostWidget(),
          ),
          CupertinoButton.filled(
            onPressed: () => Navigator.of(context)
                .push(CupertinoPageRoute(builder: (_) => _CheckoutScreen())),
            child: const Text('Make Payment'),
          ),
          SizedBox(height: 16),
          CupertinoButton.filled(
            onPressed: () => _clear(context),
            color: CupertinoColors.destructiveRed,
            child: const Text('Clear Cart'),
          )
        ]),
      ),
    ]);
  }
}

extension on ShoppingCart {
  Future<void> _clear(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Are you sure want to clear?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Provider.of<AppState>(context, listen: false).clearCart();
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

@immutable
class _CartItem extends StatelessWidget {
  const _CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppState>(context, listen: false);
    final format = NumberFormat.simpleCurrency();
    return CupertinoListTile(
      leadingSize: 60,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          product.thumb,
          package: product.package,
          fit: BoxFit.cover,
          width: 60,
          height: 60,
        ),
      ),
      title: Text(product.name, style: Styles.productItemName),
      subtitle: Text(
        '${quantity > 1 ? '$quantity x ' : ''}'
        '${format.format(product.price)}',
        style: Styles.productPriceStyle,
      ),
      additionalInfo: Text(
        format.format(quantity * product.price),
        style: Styles.productItemName,
      ),
      trailing: CupertinoButton(
        onPressed: () => model.removeFromCart(product.id),
        child: const Icon(
          CupertinoIcons.minus_circle,
          color: CupertinoColors.destructiveRed,
        ),
      ),
    );
  }
}

@immutable
class _TotalCostWidget extends StatelessWidget {
  const _TotalCostWidget();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppState>(context, listen: false);
    final format = NumberFormat.simpleCurrency();
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          'Shipping ${format.format(model.shippingCost)}',
          style: Styles.productPriceStyle,
        ),
        const SizedBox(height: 6),
        Text(
          'Tax ${format.format(model.totalTax)}',
          style: Styles.productPriceStyle,
        ),
        const SizedBox(height: 6),
        Text(
          'Total ${format.format(model.totalCost)}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
      ]),
    ]);
  }
}

@immutable
class _CheckoutScreen extends StatefulWidget {
  const _CheckoutScreen();

  @override
  State<_CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<_CheckoutScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _dateTimeCtrl = TextEditingController();
  DateTime _dateTime = DateTime.now();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _locationCtrl.dispose();
    _dateTimeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        CupertinoSliverNavigationBar(largeTitle: Text('Checkout')),
        SliverSafeArea(
          minimum: EdgeInsets.all(16),
          sliver: SliverList.separated(
            itemCount: 7,
            separatorBuilder: (_, index) => SizedBox(height: 16),
            itemBuilder: (_, index) => switch (index) {
              0 => _CheckoutTextField(
                  controller: _nameCtrl,
                  placeholder: 'Name',
                  icon: CupertinoIcons.person_solid,
                ),
              1 => _CheckoutTextField(
                  controller: _emailCtrl,
                  placeholder: 'Email',
                  icon: CupertinoIcons.mail_solid,
                ),
              2 => _CheckoutTextField(
                  controller: _locationCtrl,
                  placeholder: 'Location',
                  icon: CupertinoIcons.location_solid,
                ),
              3 => _CheckoutTextField(
                  controller: _dateTimeCtrl,
                  placeholder: 'Delivery time',
                  icon: CupertinoIcons.time,
                ),
              4 => SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    initialDateTime: _dateTime,
                    onDateTimeChanged: (value) => _dateTimeCtrl.text =
                        DateFormat.yMMMd().add_jm().format(_dateTime = value),
                  ),
                ),
              5 => _TotalCostWidget(),
              6 => CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('Checkout'),
                ),
              _ => null,
            },
          ),
        ),
      ]),
    );
  }
}

@immutable
class _CheckoutTextField extends StatelessWidget {
  const _CheckoutTextField({
    required this.icon,
    required this.placeholder,
    required this.controller,
  });

  final IconData icon;
  final String placeholder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      padding: EdgeInsets.all(16),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Icon(icon),
      ),
    );
  }
}
