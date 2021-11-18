// ignore_for_file: file_names

import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/request.dart';

class RequestProduct extends RequestService {
  final ProductItem product;
  RequestProduct({required this.product});

  Future<List<Product>> getProducts() async {
    final dioResponse = await getRequest('products');
    if (dioResponse.statusMessage == 'success') {
      var listProduct = <Product>[];
      listProduct = dioResponse.data;
      return listProduct;
    } else {
      throw 'Erro de conexão ao firebase.';
    }
  }
}
