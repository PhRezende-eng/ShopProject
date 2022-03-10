import 'dart:math';

class UserModel {
  String email;
  String password;
  String? cpf;
  String? id;

  UserModel({
    this.email = '',
    this.password = '',
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
