import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/models/order.dart';
import 'package:shop/providers/cart_map.dart';

class OrderListProvider with ChangeNotifier {
  final List<OrderModel> _item = [];

  List<OrderModel> get items => [..._item];

  int get itemsCount => _item.length;

  void addOrder(CartProvider cart) {
    _item.insert(
      0,
      OrderModel(
        id: Random().nextDouble().toString(),
        total: cart.totalPrice,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
