import 'package:shop/models/cart_item.dart';

class OrderModel {
  final String id;
  final double total;
  final List<CartItemModel> products;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      total: json['total'],
      products: json['products'],
      date: json['date'],
    );
  }
}
