import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color.fromRGBO(147, 30, 139, 1);
  static const Color operaMauve = Color.fromRGBO(138, 51, 125, 1);
  static const Color lightPurple = Color.fromRGBO(255, 244, 255,1);
  static const Color darkestPurple = Color.fromRGBO(134, 43, 129, 1);

  static const List<Color> defaultGradient = [
    primaryColor,
    darkestPurple,
    operaMauve,
  ];
}
