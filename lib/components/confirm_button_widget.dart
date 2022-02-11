// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPress;
  const ConfirmButtonWidget({
    required this.onPress,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text('$title'),
      style: ButtonStyle(),
    );
  }
}
