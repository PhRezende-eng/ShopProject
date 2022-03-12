// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class ConfirmDialogButtomWidget extends StatelessWidget {
  final Function()? onPress;
  final String text;
  const ConfirmDialogButtomWidget({
    required this.onPress,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text),
    );
  }
}
