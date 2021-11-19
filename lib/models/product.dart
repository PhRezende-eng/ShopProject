class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['mouse']['id'],
      title: json['mouse']['title'],
      description: json['mouse']['description'],
      price: json['mouse']['price'],
      imageUrl: json['mouse']['imageUrl'],
    );
  }
}
