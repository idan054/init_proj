import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // New colors
  static const Color white = Colors.white;
  static const Color grey50 = Color(0xff8D8C92);
  // static Color darkOutline = AppColors.grey50.withOpacity(0.15);
  static const Color darkOutline50 = Color(0xff4D4956);
  static const Color darkOutline = Color(0xff292533);
  static const Color primaryDark = Color(0xff221F2B);
  static const Color darkBg = Color(0xff15131a);
  static const Color green = Color(0xffB2F4B0);
  static const Color likeRed = Color(0xfff4b0b0);

  // Originals colors
  static const Color primaryOriginal = Color(0xff621BEE);
  static const Color primaryDarkOriginal = Color(0xff4914B2);
  static const Color primaryShiny = Color(0xff8027CF);
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
  TextStyle get primaryDark => copyWith(color: AppColors.primaryDarkOriginal);
  TextStyle get white => copyWith(color: AppColors.white);
  TextStyle get grey50 => copyWith(color: AppColors.grey50);
  TextStyle get darkOutline => copyWith(color: AppColors.darkOutline);
  TextStyle get darkBg => copyWith(color: AppColors.primaryDarkOriginal);
  TextStyle get green => copyWith(color: AppColors.green);

  TextStyle get primaryOriginal => copyWith(color: AppColors.primaryOriginal);
  TextStyle get primaryDarkOriginal => copyWith(color: AppColors.primaryDarkOriginal);
  TextStyle get primaryShiny => copyWith(color: AppColors.primaryDarkOriginal);
  TextStyle get primaryDisable => copyWith(color: AppColors.primaryDarkOriginal);
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
