// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/user.dart';

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
          Center(
            child: SizedBox(
              height: 160,
              width: 160,
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/without_profile_pic.png'),
                backgroundColor:
                    Theme.of(context).colorScheme.copyWith().primaryContainer,
                child: user.urlPhoto == ''
                    ? null
                    : SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: FittedBox(
                          child: ClipOval(
                            child: Image(
                              image: NetworkImage(
                                '${user.urlPhoto}',
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text('Email: ${user.email}'),
          SizedBox(height: 8),
          Text('Nome: ${user.getFullName()}'),
          SizedBox(height: 8),
          Text('Numero: ${user.number}'),
          SizedBox(height: 8),
          Text('CPF: ${user.cpf}'),
        ],
      );
    }
  }
}
