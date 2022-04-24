import 'package:flutter/material.dart';

class AppColors {
  static const Color textColor = Color(0xFFEAEBED);
  static const Color mainColor = Color(0xFF384EC7);
  static const Color signColor = Color(0xFF75E2FF);
  static const Color mainBlackColor = Color(0xFF111827);

  static MaterialColor convertColor() {
    Map<int, Color> colorCodes = {
      50: const Color.fromRGBO(255, 182, 71, 0.1),
      100: const Color.fromRGBO(255, 182, 71, 0.2),
      200: const Color.fromRGBO(255, 182, 71, .3),
      300: const Color.fromRGBO(255, 182, 71, .4),
      400: const Color.fromRGBO(255, 182, 71, .5),
      500: const Color.fromRGBO(255, 182, 71, .6),
      600: const Color.fromRGBO(255, 182, 71, .7),
      700: const Color.fromRGBO(255, 182, 71, .8),
      800: const Color.fromRGBO(255, 182, 71, .9),
      900: const Color.fromRGBO(255, 182, 71, 1),
    };

    return MaterialColor(0xFFFFB647, colorCodes);
  }
}
