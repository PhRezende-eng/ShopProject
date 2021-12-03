import 'package:flutter/cupertino.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/requestProduct.dart';

class ProductList with ChangeNotifier {
  var _items = <Product>[];
  List<Product> get items => [..._items];
  List<Product> get favoriteItem =>
      [..._items.where((product) => product.isFavorite)];

  Future<void> getProduct() async {
    //assim ele não instancia duas listas
    final items = await RequestProduct().getProducts();
    _items = items;
  }
}
