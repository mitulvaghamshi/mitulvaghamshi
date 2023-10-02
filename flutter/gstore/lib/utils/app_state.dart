import 'package:flutter/material.dart';
import 'package:gstore/utils/server.dart';

@immutable
class AppWidget extends StatefulWidget {
  const AppWidget({super.key, required this.child});

  final Widget child;

  static AppWidgetState of(context) =>
      context.findAncestorStateOfType<AppWidgetState>()!;

  @override
  AppWidgetState createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> {
  AppState _data = AppState(products: Server.getProductList());

  void setProductList(final productIds) {
    if (productIds != _data.products) {
      setState(() => _data = _data.copyWith(products: productIds));
    }
  }

  void addToCart(final id) {
    if (!_data.cartItems.contains(id)) {
      final cardItemIds = Set<String>.from(_data.cartItems);
      cardItemIds.add(id);
      setState(() => _data = _data.copyWith(cartItems: cardItemIds));
    }
  }

  void removeFromCart(final id) {
    if (_data.cartItems.contains(id)) {
      final cartItemIds = Set<String>.from(_data.cartItems);
      cartItemIds.remove(id);
      setState(() => _data = _data.copyWith(cartItems: cartItemIds));
    }
  }

  @override
  Widget build(BuildContext context) =>
      AppScope(data: _data, child: widget.child);
}

@immutable
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.data,
    required super.child,
  });

  final AppState data;

  static AppState of(final BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.data;

  @override
  bool updateShouldNotify(AppScope oldWidget) => data != oldWidget.data;
}

@immutable
class AppState {
  const AppState({
    required this.products,
    this.cartItems = const {},
  });

  final Iterable<String> products;
  final Set<String> cartItems;

  AppState copyWith({
    final Iterable<String>? products,
    final Set<String>? cartItems,
  }) {
    return AppState(
      products: products ?? this.products,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
