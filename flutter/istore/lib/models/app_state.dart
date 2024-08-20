import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:istore/models/product.dart';
import 'package:istore/utils/category.dart';
import 'package:istore/utils/server.dart';

const _salesTax = 0.6;
const _shippingCost = 7.0;

class AppState extends ChangeNotifier {
  late final _cartItems = <int, int>{};
  Category _category = Category.all;

  Map<int, int> get certItems => _cartItems;

  Category get category => _category;

  double get totalTax => subtotal * _salesTax;

  double get shippingCost => _shippingCost * cartSize;

  double get totalCost => subtotal + shippingCost + totalTax;

  int get cartSize => _cartItems.values.fold(0, (acc, count) => acc + count);

  double get subtotal => _cartItems.keys
      .map((id) => Server.getProductBy(id).price * _cartItems[id]!)
      .fold(0, (acc, price) => acc + price);

  int get inventorySize => Server.availableProducts;

  Product getProductBy(id) => Server.getProductBy(id);

  Iterable<Product> search(term) => Server.search(category, term);

  Iterable<Product> get allProducts => Server.getProductsBy(category);

  void addToCart(id) {
    _cartItems[id] = _cartItems.containsKey(id) ? _cartItems[id]! + 1 : 1;
    notifyListeners();
  }

  void removeFromCart(id) {
    if (!_cartItems.containsKey(id)) return;
    if (_cartItems[id] == 1) {
      _cartItems.remove(id);
    } else {
      _cartItems[id] = _cartItems[id]! - 1;
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void setCategory(newCategory) {
    _category = newCategory;
    notifyListeners();
  }
}
