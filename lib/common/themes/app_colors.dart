import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // New colors
  // static const Color white = Colors.white; // OLD
  static const Color white = Color(0xffEDEDF8);

  // static const Color grey50 = Color(0xff8D8C92); // OLD
  static const Color grey50 = Color(0xffCACACA); // AKA greyLight


  // static const Color darkOutline = Color(0xff292533); // OLD
  static const Color darkOutline = Color(0xff211c2d); // OLD - NEW
  static const Color chatBubble = Color(0xff292535);

  // static const Color primaryDark = Color(0xff221F2B); // OLD
  // static const Color primaryDark = Color(0xff1D1928);
  static const Color primaryDark = Color(0xff1A1626);

  // static const Color darkBg = Color(0xff15131a); // OLD
  static const Color darkBg = Color(0xff15121E);

  static const Color green = Color(0xffB2F4B0);
  static const Color likeRed = Color(0xfff4b0b0);

  // Originals colors
  // static const Color primaryOriginal = Color(0xff621BEE); // OLD
  // static const Color primaryDarkOriginal = Color(0xff4914B2); // OLD
  static const Color primaryOriginal = Color(0xff6133E4);

  static const Color primaryLight = Color(0xff624b99);

  static const Color darkOutline50 = Color(0xff4D4956); // OLD
  static const Color primaryLight2 = Color(0xff655A72);

  // static const Color primaryShiny = Color(0xff6133E4);
  static Color primaryDisable = AppColors.primaryOriginal.withOpacity(0.50);
  static const Color darkGrey = Color(0xff232323);
  static const Color greyUnavailable = Color(0xff5C5C5C);
  static const Color greyLight = Color(0xffCACACA);
  static const Color errRed = Color(0xffc22f2f);
  static const Color greenOld = Color(0xff41BE7B);

  static Color testGreen = AppColors.green.withOpacity(0.40);
  static const Color transparent = Colors.transparent;
}

extension TextStyleX on TextStyle {
  //colors
  TextStyle get primary => copyWith(color: AppColors.primaryOriginal);
  TextStyle get white => copyWith(color: AppColors.white);
  TextStyle get grey50 => copyWith(color: AppColors.grey50);
  TextStyle get darkOutline => copyWith(color: AppColors.darkOutline);
  TextStyle get green => copyWith(color: AppColors.green);
  TextStyle get primaryOriginal => copyWith(color: AppColors.primaryOriginal);
  TextStyle get darkBlack => copyWith(color: AppColors.darkBg);
  TextStyle get darkGrey => copyWith(color: AppColors.darkGrey);
  TextStyle get greyUnavailable => copyWith(color: AppColors.greyUnavailable);
  TextStyle get greyLight => copyWith(color: AppColors.greyLight);
  TextStyle get errRed => copyWith(color: AppColors.errRed);
  TextStyle get greenOld => copyWith(color: AppColors.greenOld);

  TextStyle get testGreen => copyWith(color: AppColors.testGreen);
  TextStyle get rilTopiaFont => copyWith(fontFamily: 'RilTopia');

  TextStyle lineHeight(double value) => copyWith(height: value / fontSize!);

// TextStyle spacing(double value) =>
//     copyWith(letterSpacing: calculateSpacing(value));
}
