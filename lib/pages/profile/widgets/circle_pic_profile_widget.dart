// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/user.dart';

class CircleProfilePicWidget extends StatelessWidget {
  const CircleProfilePicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SizedBox(
      height: 140,
      width: 140,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/without_profile_pic.png'),
        backgroundColor:
            Theme.of(context).colorScheme.copyWith().primaryContainer,
        child: user?.urlPhoto == '' || user?.urlPhoto == null
            ? null
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: FittedBox(
                  child: ClipOval(
                    child: Image(
                      image: NetworkImage(
                        '${user!.urlPhoto}',
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
