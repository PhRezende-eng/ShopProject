// ignore_for_file: file_names
import 'package:shop/models/product.dart';
import 'package:shop/services/request.dart';

class RequestProduct extends RequestService {
  final List<Product> _items = [];

  Future<List<Product>> getProducts() async {
    final dioResponse = await getRequest('products.json');
    var data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      data.forEach((productId, productData) {
        _items.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
          ),
        );
      });
      return _items;
    } else {
      throw 'Erro de conexão ao firebase.';
    }
  }
}
