import 'dart:math';

import 'package:shop/models/order.dart';

class UserModel {
  String email;
  String password;
  String? id;
  String? cpf;
  String? name;
  String? lastName;
  String? urlPhoto;
  String? number;
  List<OrderModel>? orders;

  UserModel({
    this.email = '',
    this.password = '',
    this.id,
    this.cpf,
    this.name,
    this.lastName,
    this.urlPhoto,
    this.number,
    this.orders,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'id': id,
        'cpf': cpf,
        'name': name,
        'lastName': lastName,
        'urlPhoto': urlPhoto,
        'number': number,
        'orders': orders,
      };

  Object toJsonObject() => {
        'email': email,
        'password': password,
        'id': id,
        'cpf': cpf,
        'name': name,
        'lastName': lastName,
        'urlPhoto': urlPhoto,
        'number': number,
        'orders': orders,
      };

  String generateId() {
    final id = Random().nextDouble().toString();
    return id.replaceAll('.', '');
  }

  String getFullName() {
    return '$name $lastName';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<OrderModel> modelOrders = [];
    for (var oder in json['orders']) {
      modelOrders.add(oder);
    }

    return UserModel(
      id: json['id'],
      cpf: json['cpf'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      lastName: json['lastName'],
      urlPhoto: json['urlPhoto'],
      number: json['number'],
      orders: modelOrders,
    );
  }
}
