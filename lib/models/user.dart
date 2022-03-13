import 'dart:math';

class UserModel {
  String email;
  String password;
  String? id;
  String? cpf;
  String? name;
  String? lastName;
  String? urlPhoto;
  String? number;

  UserModel({
    this.email = '',
    this.password = '',
    this.id,
    this.cpf,
    this.name,
    this.lastName,
    this.urlPhoto,
    this.number,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'id': generateId(),
        'cpf': cpf,
        'name': name,
        'lastName': lastName,
        'urlPhoto': urlPhoto,
        'number': number,
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
      name: json['name'],
      lastName: json['lastName'],
      urlPhoto: json['urlPhoto'],
      number: json['number'],
    );
  }
}
