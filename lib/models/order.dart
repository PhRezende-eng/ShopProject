import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/utils/util_functions.dart';

class OrderModel extends ChangeNotifier {
  final String id;
  final num total;
  final List<CartItemModel> products;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });

  String getStringData() {
    return DateFormat('dd/MM/yyyy hh:mm').format(date);
  }

  String totalPrice() {
    return Utils.formatPrice(total.toDouble());
  }

  double orderLength() {
    return products.length.toDouble();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'total': total,
        'products': products,
        'date': date.millisecondsSinceEpoch,
      };

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<CartItemModel> cartItems = [];
    for (var cart in json['products']) {
      cartItems.add(CartItemModel.fromJson(cart));
    }
    return OrderModel(
      id: json['id'],
      total: json['total'],
      products: cartItems,
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }
}
