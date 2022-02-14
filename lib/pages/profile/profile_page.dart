// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/text_buttom_widget.dart';
import 'package:shop/utils/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                onPress: () {
                  Navigator.of(context).pushNamed(AppRooutes.LOGIN);
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (contexto) => LoginWidget()));
                },
                text: 'Fazer Login',
              ),
              SizedBox(
                height: 16,
              ),
              TextButtonWidget(
                onPress: () {
                  Navigator.of(context).pushNamed(AppRooutes.REGISTER);
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (contexto) => RegisterWidget()));
                },
                text: 'Cadastre-se',
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawerWidget(),
    );
  }
}
