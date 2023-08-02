// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MyGradient {
  static Gradient getGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0, 0.44, 1],
      colors: [
        Color.fromRGBO(62, 17, 84, 1),
        Color.fromRGBO(98, 15, 96, 1),
        Color.fromRGBO(191, 0, 147, 1),
      ],
    );
  }

  static Gradient getGradient2() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.7, 1.0],
      colors: [
        Color.fromRGBO(191, 0, 147, 1),

        Color.fromRGBO(98, 15, 96, 0.5), // Couleur semi-transparente

        Color.fromRGBO(62, 17, 84, 1),
      ],
    );
  }
}
