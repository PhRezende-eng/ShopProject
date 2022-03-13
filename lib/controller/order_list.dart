import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/controller/cart_map.dart';
import 'package:shop/services/request_order.dart';

class OrderListProvider with ChangeNotifier {
  final List<OrderModel> _item = [];

  List<OrderModel> get items => [..._item];

  int get itemsCountOrder => _item.length;

  void saveOrder(BuildContext context, List<CartItemModel> cartItems) async {
    final user = Provider.of<UserProvider>(context).user!;
    await Provider.of<RequestOrderProvider>(context, listen: false)
        .postOrder(items[0], cartItems, user);
  }

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
