import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // New colors
  static const Color white = Color(0xff121207);
  // static const Color grey50 = Color(0xff353535);
  static const Color grey50 = Color(0xff64678B); // SAME AS AppColors.greyLight
  // static const Color darkOutline = Color(0xffd8d3e3);
  static const Color darkOutline = Color(0xffF8FAFF); // OLD - NEW
  static const Color chatBubble = Color(0xff292535);
  // static const Color primaryDark = Color(0xffcdcad9);
  static const Color primaryDark = Color(0xffffffff);
  // static const Color darkBg = Color(0xffe4e1ed);
  static const Color darkBg = Color(0xffffffff);
  static const Color green = Color(0xffB2F4B0);
  static const Color likeRed = Color(0xfff4b0b0);

  // Originals colors
  static const Color primaryOriginal = Color(0xff7047E7);
  static const Color primaryLight = Color(0xff624b99);
  // static const Color darkOutline50 = Color(0xff4D4956); // OLD
  static const Color lightOutline50 = Color(0xffF4F1FD); // OLD
  static const Color darkOutline50 = Color(0xffc8c8c8); // OLD
  static const Color primaryLight2 = Color(0xff655A72);

  // static const Color primaryShiny = Color(0xff6133E4);
  static Color primaryDisable = AppColors.primaryOriginal.withOpacity(0.50);
  static const Color darkGrey = Color(0xffF3F6FC);
  static const Color greyUnavailable = Color(0xffa3a3a3);
  static const Color greyLight = Color(0xff64678B);
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
