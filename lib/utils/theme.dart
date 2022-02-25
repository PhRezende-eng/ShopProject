// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LightTheme extends ColorScheme {
  static Color primaryColor = Color(0xFF40A828);
  static Color secondaryColor = Color(0xFF2D2E2F);
  static Color backgroundColor = Colors.white;
  static Color backgroundLightColor = Colors.white;
  static Color errorColor = Color(0xFFF44336);
  static Color successColor = Color(0xFF4CAF50);
  static Color formColor = Color(0xFFF7F7F7);
  static Color grayDarkColor = Color(0xFF707070);
  static Color grayMidColor = Color(0xFFE9E9E9);
  static Color grayLightColor = Color(0xFFF9F9F9);
  LightTheme()
      : super(
          background: backgroundColor,
          secondary: secondaryColor,
          onSurface: secondaryColor,
          primary: primaryColor,
          onPrimary: backgroundColor,
          surface: backgroundColor,
          primaryContainer: primaryColor,
          onBackground: secondaryColor,
          error: errorColor,
          onError: backgroundColor,
          brightness: Brightness.light,
          secondaryContainer: secondaryColor,
          onSecondary: backgroundColor,
        );
}

class DarkTheme extends ColorScheme {
  static Color primaryColor = Color(0xFF40A828);
  static Color secondaryColor = Colors.white;
  static Color backgroundColor = Color(0xFF2D2E2F);
  static Color errorColor = Color(0xFFF44336);
  static Color successColor = Color(0xFF4CAF50);
  static Color formColor = Color(0xFFF7F7F7);
  DarkTheme()
      : super(
          background: backgroundColor,
          secondary: secondaryColor,
          onSurface: secondaryColor,
          primary: primaryColor,
          onPrimary: secondaryColor,
          surface: backgroundColor,
          primaryContainer: primaryColor,
          onBackground: secondaryColor,
          error: errorColor,
          onError: secondaryColor,
          brightness: Brightness.dark,
          secondaryContainer: secondaryColor,
          onSecondary: backgroundColor,
        );
}

//  ThemeData(
//           colorScheme: ColorScheme.fromSwatch(
//             primarySwatch: Colors.green,
//           ).copyWith(
//             primary: Colors.purple[400],
//             secondary: Colors.deepOrangeAccent,
//             background: Colors.orange[200],
//             primaryVariant: Colors.grey[100],
//             secondaryVariant: Colors.grey[400],
//           ),
//           fontFamily: 'Poppins',
//         )
class MyThemeData {
  static get ligthTheme => LightTheme();

  static get darkTheme => DarkTheme();
}
