import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/server/server.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

const _salesTax = 0.6;
const _shippingCost = 7.0;

class AppState extends ChangeNotifier {
  late final _cartItems = <int, int>{};

  Category _category = .all;
  Category get category => _category;
  set category(Category newCategory) {
    _category = newCategory;
    notifyListeners();
  }

  Map<int, int> get certItems {
    _cartItems.removeWhere((key, count) => count < 1);
    return _cartItems;
  }

  int get cartSize => _cartItems.values.fold(0, (acc, count) => acc + count);

  double get subtotal => _cartItems.keys
      .map((id) => getProductBy(id).price * _cartItems[id]!)
      .fold(0, (acc, price) => acc + price);

  double get totalTax => subtotal * _salesTax;
  double get shippingCost => _shippingCost * cartSize;
  double get totalCost => subtotal + shippingCost + totalTax;

  int get inventorySize => Server.availableProducts;

  Product getProductBy(int id) => Server.getProduct(id);

  Iterable<Product> search(String term) => Server.filter(category, term);

  Iterable<Product> get allProducts => search('');

  void addToCart(int id) {
    _cartItems.update(id, (count) => count + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(int id) {
    if (!_cartItems.containsKey(id)) return;
    _cartItems.update(id, (count) => count - 1);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
