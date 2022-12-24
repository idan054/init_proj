import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // New colors
  static const Color primary = Color(0xff6133E4);
  static const Color primaryDark = Color(0xff5324DB);
  static const Color white = Colors.white;
  static const Color grey50 = Color(0xff8D8C92);
  // static Color darkOutline = AppColors.grey50.withOpacity(0.15);
  static const Color darkOutline = Color(0xff292533);
  static const Color darkBg = Color(0xff221F2B);
  static const Color green = Color(0xffB2F4B0);
  static const Color likeRed = Color(0xfff4b0b0);

  // Originals colors
  static const Color primaryOriginal = Color(0xff621BEE);
  static const Color primaryDarkOriginal = Color(0xff4914B2);
  static const Color primaryShiny = Color(0xff8027CF);
  static Color primaryDisable = AppColors.primary.withOpacity(0.50);
  static const Color darkBlack = Color(0xff0F0F0F);
  static const Color darkGrey = Color(0xff232323);
  static const Color greyUnavailable = Color(0xff5C5C5C);
  static const Color greyLight = Color(0xffCACACA);
  static const Color errRed = Color(0xffc22f2f);
  static const Color greenOld = Color(0xff41BE7B);

  static Color testGreen = AppColors.green.withOpacity(0.70);
  static const Color transparent = Colors.transparent;
}

extension TextStyleX on TextStyle {
  //colors
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get primaryDark => copyWith(color: AppColors.primaryDark);
  TextStyle get white => copyWith(color: AppColors.white);
  TextStyle get grey50 => copyWith(color: AppColors.grey50);
  TextStyle get darkOutline => copyWith(color: AppColors.darkOutline);
  TextStyle get darkBg => copyWith(color: AppColors.darkBg);
  TextStyle get green => copyWith(color: AppColors.green);

  TextStyle get primaryOriginal => copyWith(color: AppColors.primaryOriginal);
  TextStyle get primaryDarkOriginal => copyWith(color: AppColors.primaryDarkOriginal);
  TextStyle get primaryShiny => copyWith(color: AppColors.primaryShiny);
  TextStyle get primaryDisable => copyWith(color: AppColors.primaryDisable);
  TextStyle get darkBlack => copyWith(color: AppColors.darkBlack);
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
