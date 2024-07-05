import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#006C79");
  static Color primary50 = primary.withOpacity(0.5);
  static Color lightGreen = HexColor.fromHex("#C7E9E3");
  static Color lightGrey = HexColor.fromHex("#ECECEC");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
