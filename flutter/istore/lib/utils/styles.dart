import 'package:flutter/cupertino.dart';

abstract class Styles {
  static const TextStyle productItemName = TextStyle(fontSize: 18);

  static const TextStyle productRowTotal =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle productItemPrice = TextStyle(
      color: Color(0xFF848484), fontSize: 14, fontWeight: FontWeight.w300);

  static const TextStyle deliveryTimeLabel = TextStyle(
      color: Color(0xFF4D4D4D), fontWeight: FontWeight.w400);

  static const BoxDecoration boxDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 0,
        color: CupertinoColors.inactiveGray,
      ),
    ),
  );

  static const Color productDivider = Color(0xFFDBDBDB);

  static const Color scaffoldBackground = Color(0xfff0f0f0);

  static const Color searchBackground = Color(0xffe0e0e0);

  static const Color searchCursorColor = Color(0xFF007AFF);

  static const Color searchIconColor = Color(0xFF808080);
}
