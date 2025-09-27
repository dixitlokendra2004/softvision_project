import 'package:flutter/material.dart';

class AppColors {
  static Color gray800 = fromHex('#343e42');
  static Color white = fromHex('#ffffff');
  static Color gray600 = fromHex('#676e71');
  static Color blueGray5002 = fromHex('#e8eef3');
  static Color gray100 = fromHex('#f7f7f7');
  static Color yellow70033 = fromHex('#33edbc2c');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

}