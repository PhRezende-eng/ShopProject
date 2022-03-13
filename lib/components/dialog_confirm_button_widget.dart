// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class ConfirmDialogButtomWidget extends StatelessWidget {
  final Color? color;
  final Function()? onPress;
  final String text;
  const ConfirmDialogButtomWidget({
    this.color,
    required this.onPress,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color),
      onPressed: onPress,
      child: Text(text),
    );
  }
}
