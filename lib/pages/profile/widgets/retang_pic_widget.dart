// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/user.dart';

class RetangPicProfileWidget extends StatelessWidget {
  const RetangPicProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 240,
      width: 240,
      child: user?.urlPhoto == '' || user?.urlPhoto == null
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: Image(
                image: NetworkImage(
                  '${user!.urlPhoto}',
                ),
              ),
            ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.copyWith().primaryContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/without_profile_pic.png'),
        ),
      ),
    );
  }
}
