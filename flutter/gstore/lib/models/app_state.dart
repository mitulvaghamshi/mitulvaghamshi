import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';
import 'package:gstore/utils/server.dart';

class AppState extends ChangeNotifier {
  void call() => loadProducts();

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

  Product getProductBy(int id) => Server.getProductBy(id.toString());

  void loadProducts([String filter = '']) {
    products = Server.getProductList(filter);
  }

  void toggleSearch() {
    _isSearchActive = !_isSearchActive;
    loadProducts();
    notifyListeners();
  }

  void addToCart(String id) {
    if (cart.add(id)) notifyListeners();
  }

  void removeFromCart(String id) {
    if (cart.remove(id)) notifyListeners();
  }
}
