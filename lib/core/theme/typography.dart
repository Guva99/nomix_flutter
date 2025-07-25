import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {



  static TextStyle _montserrat({FontWeight? fontWeight, double? fontSize, double? letterSpacing, double? height}) =>
      GoogleFonts.montserrat(fontWeight: fontWeight, fontSize: fontSize, letterSpacing: letterSpacing, height: height).copyWith(

      );

  static TextStyle rubik({FontWeight? fontWeight, double? fontSize, double? letterSpacing, double? height}) =>
      GoogleFonts.rubik(fontWeight: fontWeight, fontSize: fontSize, letterSpacing: letterSpacing, height: height).copyWith(

      );

  ///_montserrat
  static TextStyle get font8Regular => _montserrat(fontSize: 8);
  static TextStyle get rubik40 => rubik(fontSize: 50);
  static TextStyle get font10Regular => _montserrat(fontSize: 10);
  static TextStyle get font12Regular => _montserrat(fontSize: 12);
  static TextStyle get font13Regular => _montserrat(fontSize: 13);
  static TextStyle get font14Regular => _montserrat(fontSize: 14);
  static TextStyle get font15Regular => _montserrat(fontSize: 15);
  static TextStyle get font16Regular => _montserrat(fontSize: 16);
  static TextStyle get font18Regular => _montserrat(fontSize: 18);
  static TextStyle get font20Regular => _montserrat(fontSize: 20);
  static TextStyle get font22Regular => _montserrat(fontSize: 22);
  static TextStyle get font24Regular => _montserrat(fontSize: 24);
  static TextStyle get font26Regular => _montserrat(fontSize: 26);
  static TextStyle get font28Regular => _montserrat(fontSize: 28);
  static TextStyle get font30Regular => _montserrat(fontSize: 30);
  static TextStyle get font32Regular => _montserrat(fontSize: 32);
  static TextStyle get font44Regular => _montserrat(fontSize: 44);
  // Продолжите для других размеров шрифта аналогичным образом

  static TextStyle get textTitle => _montserrat(fontWeight: FontWeight.w600, fontSize: 24, height: 32 / 24, letterSpacing: 0);
}

extension Weights on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get heavy => copyWith(fontWeight: FontWeight.w800);
}
