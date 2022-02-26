import 'package:flutter/cupertino.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/request_product.dart';

class ProductListProvider with ChangeNotifier {
  var _items = <ProductModal>[];
  List<ProductModal> get items => [..._items];
  List<ProductModal> get favoriteItem =>
      [..._items.where((product) => product.isFavorite)];

  void clearListItems() {
    _items.clear();
    notifyListeners();
  }

  Future deleteItemFromList(ProductModal product) async {
    await RequestProductProvider().deleteItemFromDB(product);
    _items.remove(product);
    // _items.removeWhere((productFromList) => productFromList.id == product.id);
    notifyListeners();
  }

  int get productLitCount => items.length;

  Future getProduct() async {
    final items = await RequestProductProvider().getProducts();
    _items = items;
    notifyListeners();
  }
}
