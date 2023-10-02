import 'package:istore/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    super.key,
    required this.dateTime,
    required this.onPick,
  });

  final DateTime dateTime;
  final Function(DateTime dateTime) onPick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(children: [
        Row(children: [
          const Icon(
            CupertinoIcons.clock,
            color: CupertinoColors.systemGrey,
            size: 28,
          ),
          const SizedBox(width: 6),
          const Text(
            'Delivery time',
            style: Styles.deliveryTimeLabel,
          ),
          const Spacer(),
          Text(DateFormat.yMMMd().add_jm().format(dateTime)),
        ]),
        const Divider(color: CupertinoColors.inactiveGray),
        SizedBox(
          height: 150,
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            onDateTimeChanged: onPick,
          ),
        ),
      ]),
    );
  }
}
