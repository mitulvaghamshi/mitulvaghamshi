import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istore/models/app_state.dart';
import 'package:istore/widgets/cart_item.dart';
import 'package:istore/widgets/cart_text_field.dart';
import 'package:istore/widgets/clear_cart_button.dart';
import 'package:istore/widgets/date_time_picker.dart';
import 'package:istore/widgets/final_cost_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@immutable
class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  ShoppingCartState createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();
  late final _locationController = TextEditingController();
  late final _currencyFormat = NumberFormat.currency(symbol: r'$');
  DateTime _dateTime = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppState>(context);
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: const Text('Shopping Cart'),
        trailing: TextButton(onPressed: () {}, child: const Text('Checkout')),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
          final products = model.certItems;
          return switch (index) {
            0 => CartTextField(
                placeholder: 'Name',
                icon: CupertinoIcons.person_solid,
                controller: _nameController),
            1 => CartTextField(
                placeholder: 'Email',
                icon: CupertinoIcons.mail_solid,
                controller: _emailController),
            2 => CartTextField(
                placeholder: 'Location',
                icon: CupertinoIcons.location_solid,
                controller: _locationController),
            3 => DateTimePicker(
                dateTime: _dateTime,
                onPick: (value) => setState(() => _dateTime = value)),
            4 => ClearCartButton(model: model),
            _ => products.length > index - 5
                ? CartItem.from(
                    index: index,
                    format: _currencyFormat,
                    model: model,
                  )
                : products.length == index - 5 && products.isNotEmpty
                    ? FinalCostWidget(model: model, format: _currencyFormat)
                    : null
          };
        }),
      ),
    ]);
  }
}
