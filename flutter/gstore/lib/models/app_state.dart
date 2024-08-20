import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';
import 'package:gstore/utils/server.dart';

class AppState extends ChangeNotifier {
  bool _isSearchActive = false;
  bool get isSearchActive => _isSearchActive;

  final Set<String> _cart = <String>{};
  Set<String> get cart => _cart;

  Iterable<String> _products = Server.getProductList();
  Iterable<String> get products => _products;
  set products(Iterable<String> value) {
    if (_products == value) return;
    _products = value;
    notifyListeners();
  }

  Product getProductBy(final int id) => Server.getProductBy(id.toString());

  Future<void> getProducts([String filter = '']) async {
    products = Server.getProductList(filter);
  }

  void toggleSearch() {
    _isSearchActive = !_isSearchActive;
    getProducts();
    notifyListeners();
  }

  void addToCart(final String id) {
    if (cart.add(id)) notifyListeners();
  }

  void removeFromCart(final String id) {
    if (cart.remove(id)) notifyListeners();
  }
}
