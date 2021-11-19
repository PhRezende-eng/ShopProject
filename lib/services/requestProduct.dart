// ignore_for_file: file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/request.dart';

class RequestProduct extends RequestService {
  Future<Product> getProducts() async {
    final dioResponse = await dio.get(
        'https://shop-coder-bccc3-default-rtdb.firebaseio.com/products.json');
    var data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      data = Product.fromJson(data);
      return data;
    } else {
      throw 'Erro de conexão ao firebase.';
    }
  }
}
