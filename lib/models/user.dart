import 'dart:math';

class UserModel {
  final String? email;
  final String? cpf;
  final String? id;
  final String? password;

  UserModel({
    this.cpf,
    this.email,
    this.password,
    this.id,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'cpf': cpf,
        'id': generateId(),
        'password': password,
      };

  String generateId() {
    return Random().nextDouble().toString();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      cpf: json['cpf'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
    );
  }
}
