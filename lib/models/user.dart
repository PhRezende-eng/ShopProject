import 'dart:math';

class UserModel {
  final String email;
  final String cpf;
  final String? id;
  final String? password;

  UserModel({
    required this.cpf,
    required this.email,
    this.password,
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
