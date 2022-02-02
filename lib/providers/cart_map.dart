import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items => {..._items};

  int itemCountCart = 0;

  double get totalPrice {
    double totalPrice = 0;
    _items.forEach((key, cartItemValue) {
      totalPrice += (cartItemValue.price * cartItemValue.quantity);
    });
    return totalPrice;
  }

  void addItem(ProductModal product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (cartItemValue) => CartItemModel(
          id: cartItemValue.id,
          productId: cartItemValue.productId,
          name: cartItemValue.name,
          price: cartItemValue.price,
          quantity: cartItemValue.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItemModel(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          price: product.price,
          quantity: 1,
        ),
      );
    }
    itemCountCart++;
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // void removeLastItem(ProductModal product) {
  //   _items.removeWhere((key, item) => product == item);
  // }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}
