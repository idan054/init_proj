import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xff621BEE);
  static const Color primaryDark = Color(0xff4914B2);
  static const Color primaryShiny = Color(0xff8027CF);
  static const Color darkBlack = Color(0xff0F0F0F);
  static const Color greyDark = Color(0xff232323);
  static const Color greyUnavailable = Color(0xff5C5C5C);
  static const Color greyLight = Color(0xffCACACA);
  static const Color white = Colors.white;
  static const Color green = Color(0xff41BE7B);
  static const Color transparent = Colors.transparent;
}

extension TextStyleX on TextStyle {
  //colors
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get primaryDark => copyWith(color: AppColors.primaryDark);
  TextStyle get primaryShiny => copyWith(color: AppColors.primaryShiny);
  TextStyle get darkBlack => copyWith(color: AppColors.darkBlack);
  TextStyle get greyDark => copyWith(color: AppColors.greyDark);
  TextStyle get greyUnavailable => copyWith(color: AppColors.greyUnavailable);
  TextStyle get greyLight => copyWith(color: AppColors.greyLight);
  TextStyle get white => copyWith(color: AppColors.white);
  TextStyle get green => copyWith(color: AppColors.green);

  TextStyle lineHeight(double value) => copyWith(height: value / fontSize!);

// TextStyle spacing(double value) =>
//     copyWith(letterSpacing: calculateSpacing(value));
}
