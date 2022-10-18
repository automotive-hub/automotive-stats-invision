import 'package:flutter/material.dart';

class ConstColor {
  static const Color background = Color(0xff2c3036);

  static const Color whiteText = Colors.white;
  static const Color success = Color(0xff34c759);
  static const Color fail = Colors.red;
  static const Color loading = Colors.red;
  static const Color border = Color(0xff989a9d);
  static const Color none = Colors.transparent;

  static const LinearGradient colorFullGradient = LinearGradient(colors: [
    Color(0xff428b04),
    Color(0xffc4770d),
  ]);
  static const LinearGradient greyGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 255, 255, 0.3),
      Color.fromRGBO(0, 0, 0, 0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
