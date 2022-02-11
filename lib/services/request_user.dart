import 'package:shop/models/user.dart';
import 'package:shop/services/request.dart';

class RequestUserProvider extends RequestService {
  UserModel? _user;
  UserModel? get user => _user;

  Future getUser() async {
    final dioResponse = await getRequest('/login.json');
    Map<String, UserModel> data = dioResponse.data;
    if (dioResponse.statusMessage == 'OK') {
      _user = UserModel.fromJson(data);
    } else {
      throw 'Não foi possível verificar se o usuário já está logado.';
    }
  }

  Future loginUser(Map user) async {
    final dioResponse = await postRequest(
      '/login.json',
      body: user,
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Conta logada com sucesso!';
    } else {
      throw 'Não foi possível fazer login, tente novamente mais tarde.';
    }
  }

  Future logoutUser(UserModel user) async {
    final dioResponse = await deleteRequest(
      '/login.json',
      body: user.toJson(),
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Conta deslogada com sucesso!';
    } else {
      throw 'Não foi possível fazer logout, tente novamente mais tarde.';
    }
  }

  Future registerUser(UserModel user) async {
    final dioResponse = await postRequest(
      '/register.json',
      body: user.toJson(),
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Usuário cadastrado com sucesso!';
    } else {
      throw 'Não foi possível cadastrar o usuário, tente novamente mais tarde.';
    }
  }

  Future deleteUser(UserModel user) async {
    final dioResponse = await deleteRequest(
      '/register.json',
      body: user.toJson(),
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Usuário deletado com sucesso!';
    } else {
      throw 'Não foi possível deletar o usuário, tente novamente mais tarde.';
    }
  }
}
