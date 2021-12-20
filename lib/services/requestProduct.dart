// ignore_for_file: file_names, unused_field

import 'package:shop/models/product.dart';
import 'package:shop/services/request.dart';

class RequestProduct extends RequestService {
  final List<Product> _items = [];

  Future<List<Product>> getProducts() async {
    final dioResponse = await getRequest('products.json');
    Map<String, dynamic> data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      for (var dict in data.values) {
        var modelProduct = Product.fromJson(dict);
        _items.add(modelProduct);
      }

      return _items;

      // data.forEach((productId, productData) {
      //   _items.add(
      //     Product(
      //         id: productId, // aqui neste caso a gente pega Id da KEY
      //         title: productData['title'],
      //         description: productData['description'],
      //         price: productData['price'],
      //         imageUrl: productData['imageUrl'],
      //         isFavorite: productData['isFavorite'] ?? false),
      //   );
      // });

      // return _items;
    } else {
      throw 'Erro de conexão ao firebase.\nTente novamente mais tarde.';
    }
  }

  Future<bool> patchFavoriteRequest(Product product,
      {required bool isFavorite}) async {
    final dict = {
      'isFavorite': isFavorite,
    };

    final dioResponse = await patchRequest(
      'products/${product.name}.json',
      body: dict,
    );
    if (dioResponse.statusMessage == 'OK') {
      return true;
    } else {
      throw 'Erro ao tentar favoritar um produto.\nTente novamente mais tarde.';
    }
  }
}
