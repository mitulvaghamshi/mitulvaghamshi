import 'package:cupertino_store/pages/cart/widgets/cart_total_widget.dart';
import 'package:cupertino_store/pages/checkout/widgets/checkout_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

@immutable
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _dateTimeCtrl = TextEditingController();

  DateTime _dateTime = .now();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _locationCtrl.dispose();
    _dateTimeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text('Checkout')),
        SliverSafeArea(
          minimum: const .all(16),
          sliver: SliverList.separated(
            itemCount: 7,
            separatorBuilder: (_, index) => const SizedBox(height: 16),
            itemBuilder: (_, index) => switch (index) {
              0 => CheckoutTextField(
                controller: _nameCtrl,
                hint: 'Name',
                prefix: const Icon(CupertinoIcons.person_solid),
              ),
              1 => CheckoutTextField(
                controller: _emailCtrl,
                hint: 'Email',
                prefix: const Icon(CupertinoIcons.mail_solid),
              ),
              2 => CheckoutTextField(
                controller: _locationCtrl,
                hint: 'Location',
                prefix: const Icon(CupertinoIcons.location_solid),
              ),
              3 => CheckoutTextField(
                controller: _dateTimeCtrl,
                hint: 'Delivery time',
                prefix: const Icon(CupertinoIcons.time),
              ),
              4 => SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) => _dateTimeCtrl.text =
                      DateFormat.yMMMd().add_jm().format(_dateTime = value),
                ),
              ),
              5 => const CartTotalWidget(),
              6 => CupertinoButton.filled(
                onPressed: () {},
                child: const Text('Checkout'),
              ),
              _ => null,
            },
          ),
        ),
      ],
    ),
  );
}
