// ignore_for_file: prefer_final_fields, avoid_print

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request_user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  set setUser(UserModel? user) => _user = user;

  List<UserModel> _usersLogin = [];
  List<UserModel> _usersRegister = [];

  Future getUsersFromDB(BuildContext context) async {
    final requestUser =
        Provider.of<RequestUserProvider>(context, listen: false);

    try {
      _usersRegister = await requestUser.getRegisterUser();
      _usersLogin = await requestUser.getLoginUser();
    } catch (error) {
      // print(error);
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getString('_user');
      _user = _usersLogin.firstWhere((user) => user.email == result);
    } catch (e) {
      _user = null;
    }
  }

  void removeUserFromListUser(UserModel user) {
    _usersLogin.remove(user);
    _user = null;
    notifyListeners();
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

    if (hasUserRegister && !hasUserLogin) {
      _usersLogin.insert(0, userLogin);
      _user = userLogin;
      return true;
    } else {
      return false;
    }
  }
}
