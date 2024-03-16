import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: isDarkTheme ? Colors.white : Colors.black,
      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme ? Colors.grey : Colors.black,
      splashFactory: NoSplash.splashFactory,
      highlightColor: isDarkTheme ? Colors.transparent : Colors.transparent,
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor: isDarkTheme ? Colors.white : Colors.black87,
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),
      cardColor: isDarkTheme ? const Color(0xFF1E1D1D) : const Color(0xFFF5F6F9),
      canvasColor: isDarkTheme ? CustomColors.backgroundDark : CustomColors.backgroundLight,
      brightness: isDarkTheme ? Brightness.light : Brightness.light,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFEFDFE) : const Color(0xFFFEFCFF)),
          bodyMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFEFDFE) : const Color(0xFFFEFCFF)),
          bodySmall: TextStyle(color: isDarkTheme ? const Color(0xFFFEFDFE) : const Color(0xFFFEFCFF)),
        ),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ), 
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(background: isDarkTheme ? Colors.black : Colors.white),
    );

  }
}