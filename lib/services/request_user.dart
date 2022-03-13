import 'package:firebase_database/firebase_database.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request.dart';

class RequestUserProvider extends RequestService {
  Future<List<UserModel>> getLoginUser() async {
    final dioResponse = await getRequest('/login.json');
    final data = dioResponse.data;

    if (dioResponse.statusMessage == 'OK') {
      List<UserModel> listLoginUser = [];
      for (var user in data.values.toList()) {
        user = UserModel.fromJson(user);
        listLoginUser.add(user);
      }
      return listLoginUser;
    } else {
      throw 'Não foi possível verificar se o usuário já está logado.';
    }
  }

  Future<List<UserModel>> getRegisterUser() async {
    final dioResponse = await getRequest('/register.json');
    final data = dioResponse.data;

    if (dioResponse.statusMessage == 'OK') {
      List<UserModel> listRegisterUser = [];
      for (var user in data.values.toList()) {
        user = UserModel.fromJson(user);
        listRegisterUser.add(user);
      }
      return listRegisterUser;
    } else {
      throw 'Não foi possível verificar os usuários cadastrados.';
    }
  }

  Future loginUser(UserModel user) async {
    Map dict = user.toJson();

    final dioResponse = await postRequest(
      '/login.json',
      body: dict,
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Conta logada com sucesso!';
    } else {
      throw 'Não foi possível fazer login, tente novamente mais tarde.';
    }
  }

  Future logoutUser(UserModel user) async {
    Map dict = user.toJson();

    final dioResponse = await deleteRequest(
      '/login.json',
      body: dict,
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Conta deslogada com sucesso!';
    } else {
      throw 'Não foi possível fazer logout, tente novamente mais tarde.';
    }
  }

  Future registerUser(UserModel user) async {
    Map dict = user.toJson();

    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('posts/$user.id/starCount');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
    });
    final dioResponse = await postRequest(
      'register.json',
      body: dict,
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Usuário cadastrado com sucesso!';
    } else {
      throw 'Não foi possível cadastrar o usuário, tente novamente mais tarde.';
    }
  }

  Future deleteUser(UserModel user) async {
    // Map dict = user.toJson();

    final dioResponse = await deleteRequest(
      '/register/${user.id}.json',
      // body: dict,
    );
    if (dioResponse.statusMessage == 'OK') {
      return 'Usuário deletado com sucesso!';
    } else {
      throw 'Não foi possível deletar o usuário, tente novamente mais tarde.';
    }
  }
}
