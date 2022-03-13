// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/user.dart';
import 'package:shop/pages/profile/widgets/retang_pic_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user == null) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: RetangPicProfileWidget()),
          SizedBox(height: 16),
          Text('Email: ${user.email}'),
          SizedBox(height: 4),
          Text('Nome: ${user.getFullName()}'),
          SizedBox(height: 4),
          Text('Número: ${user.number}'),
          SizedBox(height: 4),
          Text('CPF: ${user.cpf}'),
        ],
      );
    }
  }
}
