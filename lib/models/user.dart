import 'dart:math';

class UserModel {
  final String email;
  final String? cpf;
  String? id;
  final String password;

  UserModel({
    required this.email,
    required this.password,
    this.cpf,
    this.id,
  });

  Map<String, dynamic> toJson() => {
        'id': generateId(),
        'cpf': cpf,
        'email': email,
        'password': password,
      };

  String generateId() {
    return Random().nextDouble().toString();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      cpf: json['cpf'],
      email: json['email'],
      password: json['password'],
    );
  }
}
