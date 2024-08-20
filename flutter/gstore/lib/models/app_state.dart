import 'package:flutter/material.dart';
import 'package:gstore/models/product.dart';
import 'package:gstore/utils/server.dart';

class AppState extends ChangeNotifier {
  void call() => loadProducts();

  bool _isSearchActive = false;
  bool get isSearchActive => _isSearchActive;

  final Set<String> _cart = {};
  Set<String> get cart => _cart;

  Iterable<String> _products = Server.getProducts();
  Iterable<String> get products => _products;
  set products(Iterable<String> newProducts) {
    if (_products == newProducts) return;
    _products = newProducts;
    notifyListeners();
  }

  Product getProductBy({required String id}) => Server.getProductBy(key: id);

  void loadProducts([String filter = '']) {
    products = Server.getProducts(filter);
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
