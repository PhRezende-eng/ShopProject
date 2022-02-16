// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPress;
  const TextButtonWidget({
    required this.text,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: TextButton(
        onPressed: onPress,
        child: Text(text),
      ),
    );
  }
}
