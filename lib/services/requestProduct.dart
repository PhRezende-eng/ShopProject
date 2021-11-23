// ignore_for_file: file_names
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
    } else {
      throw 'Erro de conexão ao firebase.';
    }
  }
}
