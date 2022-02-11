// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/services/request_user.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  late RequestUserProvider userProvider;
  late bool isLogin;

  @override
  void initState() {
    userProvider = Provider.of<RequestUserProvider>(context, listen: false);
    getUser();
    super.initState();
  }

  void getUser() {
    if (userProvider.user != null) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Bem vindo, usuário!'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRooutes.Home,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRooutes.ORDERS,
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar produtos'),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRooutes.PRODUCT_PAGE,
                arguments: 'Gerenciar produtos',
              );
            },
          ),
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.of(context).pushNamed(
                isLogin ? AppRooutes.PROFILE : AppRooutes.REGISTER,
              );
            },
          ),
        ],
      ),
    );
  }
}
