// ignore_for_file: file_names, unused_field
import 'dart:math';

import 'package:shop/models/product.dart';
import 'package:shop/services/request.dart';

class RequestProduct extends RequestService {
  final List<Product> _items = [];

  Future<List<Product>> getProducts() async {
    final dioResponse = await getRequest('products.json');
    Map<String, dynamic> data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      List<Product> productList = [];
      for (var dict in data.values) {
        var modelProduct = Product.fromJson(dict);
        productList.add(modelProduct);
      }

      return productList;

      // data.forEach((productId, productData) {
      //   _items.add(
      //     Product(
      //       id: productId,      // aqui neste caso a gente pega Id da KEY
      //       title: productData['title'],
      //       description: productData['description'],
      //       price: productData['price'],
      //       imageUrl: productData['imageUrl'],
      //     ),
      //   );
      // });

      // return _items;
    } else {
      throw 'Erro de conexão ao firebase.\nTente novamente mais tarde.';
    }
  }

  Future<void> putFavoriteRequest(Product product) async {
    final dict = {
      'isFavorite': !product.isFavorite,
    };
    final dioResponse =
        await putRequest('products/${product.title}.json', body: dict);
    var data = dioResponse.data;
    // if (dioResponse.statusMessage == 'OK') {
    //   return Product.fromJson(data);
    // } else {
    //   throw 'Erro ao tentar favoritar um produto.\nTente novamente mais tarde.';
    // }
  }
}
