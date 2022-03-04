// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request_user.dart';

class UserProvider with ChangeNotifier {
  UserProvider();

  List<UserModel> _usersLogin = [];
  List<UserModel> _usersRegister = [];

  String? _email;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UserModel? _user;
  UserModel? get user => _user;
  void setUser(UserModel? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }

  void setInMemoryUser(String email) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString('_user', email);
  }

  Future getInMemoryUser() async {
    SharedPreferences prefs = await _prefs;
    _email = prefs.getString('_user');
  }

  Future getUsersFromDB(BuildContext context) async {
    await Provider.of<RequestUserProvider>(context, listen: false)
        .getRegisterUser()
        .then((usersRegister) => _usersRegister = usersRegister)
        .catchError((error) => _usersRegister = []);

    await Provider.of<RequestUserProvider>(context, listen: false)
        .getLoginUser()
        .then((usersLogin) => _usersLogin = usersLogin)
        .catchError((error) => _usersLogin = []);

    await getInMemoryUser();
    if (_email != null) {
      setUser(
        _usersLogin.firstWhere(
          (element) => element.email == _email,
        ),
      );
    }
  }

  bool canRegister(UserModel userRegister) {
    var hasUserRegister =
        _usersRegister.any((user) => user.email == userRegister.email);

    if (!hasUserRegister) {
      _usersRegister.insert(0, userRegister);
      return true;
    } else {
      return false;
    }
  }

  bool canLogin(UserModel userLogin) {
    var hasUserRegister =
        _usersRegister.any((user) => user.email == userLogin.email);

    var hasUserLogin = _usersLogin.any((user) => user.email == userLogin.email);

    if (!hasUserRegister && !hasUserLogin) {
      _usersLogin.insert(0, userLogin);
      _user = userLogin;
      return true;
    } else {
      return false;
    }
  }
}
