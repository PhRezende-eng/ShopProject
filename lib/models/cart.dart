import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};
  int get itemsCount => _items.length;

  double get totalPrice {
    double totalPrice = 0;
    _items.forEach((key, cartItemValue) {
      totalPrice = (cartItemValue.price * cartItemValue.quantity).toDouble();
    });
    return totalPrice;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (cartItemValue) => CartItem(
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
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          price: product.price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}
