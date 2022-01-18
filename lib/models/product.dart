// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

class ProductModal with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  bool isFavorite;

  ProductModal({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  factory ProductModal.fromJson(Map<String, dynamic> json) {
    return ProductModal(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
