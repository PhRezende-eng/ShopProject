import 'package:flutter/cupertino.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/requestProduct.dart';

class ProductListProvider with ChangeNotifier {
  var _items = <ProductModal>[];
  List<ProductModal> get items => [..._items];
  List<ProductModal> get favoriteItem =>
      [..._items.where((product) => product.isFavorite)];

  Future<void> getProduct() async {
    //assim ele não instancia duas listas
    final items = await RequestProductProvider().getProducts();
    _items = items;
  }
}
