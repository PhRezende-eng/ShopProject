// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/user.dart';
import 'package:shop/services/request_user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  List<UserModel> _usersLogin = [];
  List<UserModel> _usersRegister = [];

  Future getUsersFromDB(BuildContext context) async {
    _usersRegister =
        await Provider.of<RequestUserProvider>(context, listen: false)
            .getRegisterUser();
    _usersLogin = await Provider.of<RequestUserProvider>(context, listen: false)
        .getLoginUser();
  }

  bool addRegisterUser(UserModel userRegister) {
    var hasUserRegister =
        _usersRegister.any((user) => user.email == userRegister.email);

    if (!hasUserRegister) {
      _usersRegister.insert(0, userRegister);
      return true;
    } else {
      return false;
    }
    // var user =
    //     _usersRegister.firstWhere((user) => user.email == userRegister.email);

    // if (user == null) {
    //   _usersRegister.insert(0, userRegister);
    //   return true;
    // } else {
    //   return false;
    // }
  }

  bool addLoginUser(UserModel userLogin) {
    var hasUserRegister =
        _usersRegister.any((user) => user.email == userLogin.email);

    var hasUserLogin = _usersLogin.any((user) => user.email == userLogin.email);

    if (!hasUserRegister && !hasUserLogin) {
      _usersLogin.insert(0, userLogin);
      return true;
    } else {
      return false;
    }

    // var hasUserRegister =
    //     _usersRegister.firstWhere((user) => user.email == userLogin.email);

    // var hasUserLogin =
    //     _usersLogin.firstWhere((user) => user.email == userLogin.email);

    // if (hasUserRegister == null && hasUserLogin == null) {
    //   _usersLogin.insert(0, userLogin);
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
