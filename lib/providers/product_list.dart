import 'package:flutter/cupertino.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/requestProduct.dart';

class ProductListProvider with ChangeNotifier {
  var _items = <ProductModal>[];
  List<ProductModal> get items => [..._items];
  List<ProductModal> get favoriteItem =>
      [..._items.where((product) => product.isFavorite)];

  void clearItems() {
    _items.clear();
    notifyListeners();
  }

  Future getProduct() async {
    clearItems();
    final items = await RequestProductProvider().getProducts();
    _items = items;
    notifyListeners();
  }
}
