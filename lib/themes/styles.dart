import 'package:flutter/material.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: isDarkTheme ? Colors.white : Colors.black,
      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme ? const Color(0xFFFEFDFE) : Colors.black87,
      splashFactory: NoSplash.splashFactory,
      highlightColor: isDarkTheme ? Colors.transparent : Colors.transparent,
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor: isDarkTheme ? Colors.white : Colors.black87,
      disabledColor: Colors.grey,
      scaffoldBackgroundColor:isDarkTheme ? CustomColors.backgroundDark : CustomColors.backgroundLight,
      cardColor: isDarkTheme ? const Color(0xFF1E1D1D) : const Color(0xFFF5F6F9),
      canvasColor: isDarkTheme ? CustomColors.backgroundDark : CustomColors.backgroundLight,
      brightness: isDarkTheme ? Brightness.light : Brightness.light,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFEFDFE) : const Color(0xFF1E1E1E)),
          bodyMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFEFDFE) : const Color(0xFF1E1E1E)),
          bodySmall: TextStyle(color: isDarkTheme ? const Color(0xFFFEFDFE) : const Color(0xFF1E1E1E)),
        ),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        foregroundColor: isDarkTheme ? CustomColors.textColorDark : CustomColors.textColorLight,
        // surfaceTintColor: CommonColors.lightColor,
      ), 
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(background: isDarkTheme ? Colors.black : Colors.white),
      dialogTheme: DialogTheme(
        backgroundColor: isDarkTheme ? CustomColors.backgroundDark : CustomColors.backgroundLight,
        titleTextStyle: isDarkTheme? const TextStyle(color: Colors.white) : const TextStyle(color: Colors.black),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return isDarkTheme ? CustomColors.primaryDark : CustomColors.primaryDark;
            }
            return Colors.transparent;
          },
        ),
      ),
    );

  }
}