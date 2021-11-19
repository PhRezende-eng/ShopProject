// ignore_for_file: file_names
import 'package:shop/models/product.dart';
import 'package:shop/services/request.dart';

class RequestProduct extends RequestService {
  Future<Product> getProducts() async {
    final dioResponse = await getRequest('products.json');
    var data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      data = Product.fromJson(data);
      return data;
    } else {
      throw 'Erro de conexão ao firebase.';
    }
  }
}
