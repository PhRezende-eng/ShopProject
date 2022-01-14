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
