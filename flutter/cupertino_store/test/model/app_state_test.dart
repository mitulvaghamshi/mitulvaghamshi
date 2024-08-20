import 'package:cupertino_store/models/app_state.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/utils/category.dart';
import 'package:test/test.dart';

void main() {
  group('Testing AppState Provider', () {
    final model = AppState();

    test('Test is loadProducts method loads the data', () {
      final list = model.allProducts; // retrieve products
      expect(list.length, 38); // total items should be 38

      // Sample product item
      const product = Product(
        id: 0,
        price: 120,
        isFeatured: true,
        name: 'Vagabond sack',
        category: Category.accessories,
      );

      // Match all properties of first product
      expect(list.first.id, product.id);
      expect(list.first.name, product.name);
      expect(list.first.price, product.price);
      expect(list.first.category, product.category);
      expect(list.first.isFeatured, product.isFeatured);
    });
  });
}
