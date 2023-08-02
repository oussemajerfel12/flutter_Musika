import 'package:flutter/material.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color.fromARGB(214, 7, 6, 26),
    hintColor: Colors.green,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16, color: Colors.grey[600]),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    hintColor: Colors.pinkAccent,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16),
      bodyText2: TextStyle(fontSize: 14),
    ),
  );
}
