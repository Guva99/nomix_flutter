import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomix/core/theme/typography.dart';

class Themes {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Raleway',
    scaffoldBackgroundColor: AppColors.bgWhite,
    primaryColor: AppColors.black,
    colorScheme: const ColorScheme.light(primary: AppColors.black),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.white),
    canvasColor: AppColors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 61),
        textStyle: AppTypography.font16Regular,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: AppColors.white,
       centerTitle: true,
    ),

    textTheme: const TextTheme(),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    ),
  );

  static ThemeData get darkTheme => lightTheme;
}

abstract class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color bgWhite = Color(0xFFF7FAFE);

  static const Color black = Color(0xFF141414);
  static const Color red = Color(0xFFFF4820);

  static const Color black50 = Color(0xFF414049);
  static const Color gray = Color(0xFF7A8A98);
  static const Color gray100 = Color(0xFFF4F4F4);
   static const Color primaryBlue = Color(0xFF3776F0);
  static const Color accentColor = Color(0xFF5A3B9E);
  static const Color primaryBlueLight = Color(0xFF709AEC);
  static const Color orangeFood = Color(0xFFF7A963);
  static const Color pinkAccent = Color(0xFFFC7AD7);
  static const Color yellowAccent = Color(0xFFD8C32B);
  static const Color green = Color(0xFF7DCB76);


  static const Gradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF42A5F5),
      Color(0xFF478DE0),
      Color(0xFF5C6BC0),
    ],
  );

  static   Gradient gradient2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      accentColor,
      primaryBlue.withOpacity(0.3),
      primaryBlue.withOpacity(0.1),
    ],
  );
}
