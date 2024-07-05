import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main colors of the app
    primaryColor: ColorManager.primary,

    // Text theme
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_1,
        fontSize: 64,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 40,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 24,
      ),
      displaySmall: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 13,
        color: Colors.black54,
      ),
      displayMedium: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 15,
        color: Colors.black54,
      ),
    ),
  );
}
