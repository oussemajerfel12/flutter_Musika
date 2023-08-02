// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromRGBO(62, 17, 84, 1),
    Color.fromRGBO(191, 0, 147, 1),
  ],
  stops: [0, 0.44, 1],
);

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? gradient.colors[0] : null,
      textTheme: TextTheme(
        // ignore: deprecated_member_use
        headline1: isDarkTheme
            ? TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
            : TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),

        headline2: isDarkTheme
            ? TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
            : TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        headline4: isDarkTheme
            ? TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
            : TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),

        headline3: isDarkTheme
            ? TextStyle(fontSize: 16, color: Colors.white)
            : TextStyle(fontSize: 16, color: Colors.black),
        bodyText1: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
      primarySwatch: Colors.purple,
      primaryColor:
          isDarkTheme ? gradient.colors[0] : Color.fromARGB(255, 244, 239, 239),
      primaryColorLight: isDarkTheme
          ? Color.fromARGB(255, 244, 239, 239)
          : Color.fromARGB(255, 10, 10, 27),
      backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? Colors.grey.shade300 : Color.fromARGB(255, 0, 0, 0),
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}
