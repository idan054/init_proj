import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service/mixins/fonts.gen.dart';




class AppStyles {
  const AppStyles._();
  // static TextStyle get heeboFont => GoogleFonts.palanquin();
  // static TextStyle get nunitoFont => GoogleFonts.nunitoSans();
  // static TextStyle get lexendFont => GoogleFonts.lexend();
  static TextStyle get lexendFont => const TextStyle(
    fontFamily: FontFamily.lexendRegular
  );

  static TextStyle get lexendFontMedium => const TextStyle(
      fontFamily: FontFamily.lexendMedium
  );

  static TextStyle get lexendFontBold => const TextStyle(
      fontFamily: FontFamily.lexendBold
  );

  // static TextStyle get text8PxRegular => lexendFont.copyWith(
  //       fontSize: 8.sp,
  //       fontWeight: FontWeight.w400,
  //     );

  //light
  static TextStyle get text30PxLight => lexendFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text26PxLight => lexendFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text24PxLight => lexendFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text20PxLight => lexendFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text18PxLight => lexendFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text16PxLight => lexendFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text14PxLight => lexendFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text12PxLight => lexendFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      );

  //regular
  static TextStyle get text30PxRegular => lexendFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text26PxRegular => lexendFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text24PxRegular => lexendFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text23PxRegular => lexendFont.copyWith(
        fontSize: 23.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text23PxMedium => lexendFont.copyWith(
        fontSize: 23.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get text23PxSemiBlod => lexendFont.copyWith(
        fontSize: 23.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text20PxRegular => lexendFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text18PxRegular => lexendFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text16PxRegular => lexendFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text14PxRegular => lexendFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text10PxRegular => lexendFont.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text12PxRegular => lexendFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

//medium

  static TextStyle get text30PxMedium => lexendFontMedium.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text26PxMedium => lexendFontMedium.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text24PxMedium => lexendFontMedium.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text20PxMedium => lexendFontMedium.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text19PxMedium => lexendFontMedium.copyWith(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text18PxMedium => lexendFontMedium.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text16PxMedium => lexendFontMedium.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text14PxMedium => lexendFontMedium.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text12PxMedium => lexendFontMedium.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text10PxMedium => lexendFontMedium.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
      );

//semi `bold`

  static TextStyle get text30PxSemiBold => lexendFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text26PxSemiBold => lexendFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text24PxSemiBold => lexendFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text20PxSemiBold => lexendFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text18PxSemiBold => lexendFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text16PxSemiBold => lexendFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text14PxSemiBold => lexendFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text12PxSemiBold => lexendFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text10PxSemiBold => lexendFont.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      );

  //bold
  static TextStyle get text30PxBold => lexendFontBold.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text26PxBold => lexendFontBold.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text24PxBold => lexendFontBold.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text20PxBold => lexendFontBold.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text19PxBold => lexendFontBold.copyWith(
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text18PxBold => lexendFontBold.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text16PxBold => lexendFontBold.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text14PxBold => lexendFontBold.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text12PxBold => lexendFontBold.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text10PxBold => lexendFontBold.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get text8pxBold => lexendFontBold.copyWith(
        fontSize: 8.sp,
        fontWeight: FontWeight.bold,
      );
}

double calculateSpacing(double em) {
  return 16 * em;
}
