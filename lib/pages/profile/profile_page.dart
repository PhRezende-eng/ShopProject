// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/confirm_buttom_widget.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/pages/profile/widgets/profile_info_widget.dart';
import 'package:shop/services/request_user.dart';
import 'package:shop/utils/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final requestUserProvider =
        Provider.of<RequestUserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: userProvider.user != null
            ? Column(
                children: [
                  ProfileInfoWidget(),
                  Spacer(),
                  TextButtonWidget(
                    onPress: () {
                      requestUserProvider.logoutUser(userProvider.user!);
                      userProvider.removeUserFromDevice();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    text: 'Fazer logout',
                  )
                ],
              )
            : Column(
                children: [
                  Spacer(),
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
      drawer: AppDrawerWidget(),
    );
  }
}
