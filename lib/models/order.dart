import 'package:shop/models/cart_item.dart';

class OrderModel {
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
