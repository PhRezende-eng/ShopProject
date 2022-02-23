import 'package:flutter/material.dart';

import 'theme.dart';

class LightTextTheme extends TextTheme {
  LightTextTheme()
      : super(
          headline1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: LightTheme.secondaryColor,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: LightTheme.secondaryColor,
          ),
          headline3: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: LightTheme.secondaryColor,
          ),
          headline4: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: LightTheme.secondaryColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: LightTheme.secondaryColor,
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: LightTheme.secondaryColor,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: LightTheme.secondaryColor,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: LightTheme.secondaryColor,
          ),
          button: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: LightTheme.secondaryColor,
          ),
          overline: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: LightTheme.secondaryColor,
          ),
        );
}

class DarkTextTheme extends TextTheme {
  DarkTextTheme()
      : super(
          headline1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 40,
            color: DarkTheme.secondaryColor,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
            color: DarkTheme.secondaryColor,
          ),
          headline3: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: DarkTheme.secondaryColor,
          ),
          headline4: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: DarkTheme.secondaryColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: DarkTheme.secondaryColor,
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: DarkTheme.secondaryColor,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: DarkTheme.secondaryColor,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: DarkTheme.secondaryColor,
          ),
          button: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: DarkTheme.secondaryColor,
          ),
          overline: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DarkTheme.secondaryColor,
          ),
        );
}
