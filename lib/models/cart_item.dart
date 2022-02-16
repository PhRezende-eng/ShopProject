import 'package:shop/utils/util_functions.dart';

class CartItemModel {
  final String id;
  final String productId;
  final String name;
  final num price;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  String productPriceWithouR$() {
    return Utils.formatPriceWithoutR$(price.toDouble());
  }

  String totalPrice() {
    return Utils.formatPrice((price * quantity).toDouble());
  }

  String productPrice() {
    return Utils.formatPrice(price.toDouble());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
