import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class AppStyles {
  const AppStyles._();
  static TextStyle get heeboFont => GoogleFonts.palanquin();

  static TextStyle get text8PxRegular => heeboFont.copyWith(
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
      );

  //light
  static TextStyle get text30PxLight => heeboFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text26PxLight => heeboFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text24PxLight => heeboFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text20PxLight => heeboFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text18PxLight => heeboFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text16PxLight => heeboFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text14PxLight => heeboFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get text12PxLight => heeboFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      );

  //regular
  static TextStyle get text30PxRegular => heeboFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text26PxRegular => heeboFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text24PxRegular => heeboFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text23PxRegular => heeboFont.copyWith(
        fontSize: 23.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text23PxMedium => heeboFont.copyWith(
        fontSize: 23.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get text23PxSemiBlod => heeboFont.copyWith(
        fontSize: 23.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text20PxRegular => heeboFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text18PxRegular => heeboFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text16PxRegular => heeboFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text14PxRegular => heeboFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text10PxRegular => heeboFont.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text12PxRegular => heeboFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

//medium

  static TextStyle get text30PxMedium => heeboFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text26PxMedium => heeboFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text24PxMedium => heeboFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text20PxMedium => heeboFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text19PxMedium => heeboFont.copyWith(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text18PxMedium => heeboFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text16PxMedium => heeboFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text14PxMedium => heeboFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text12PxMedium => heeboFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text10PxMedium => heeboFont.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
      );

//semi `bold`

  static TextStyle get text30PxSemiBold => heeboFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text26PxSemiBold => heeboFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text24PxSemiBold => heeboFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text20PxSemiBold => heeboFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text18PxSemiBold => heeboFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text16PxSemiBold => heeboFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text14PxSemiBold => heeboFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text12PxSemiBold => heeboFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text10PxSemiBold => heeboFont.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      );

  //bold
  static TextStyle get text30PxBold => heeboFont.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text26PxBold => heeboFont.copyWith(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text24PxBold => heeboFont.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text20PxBold => heeboFont.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text19PxBold => heeboFont.copyWith(
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text18PxBold => heeboFont.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text16PxBold => heeboFont.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text14PxBold => heeboFont.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text12PxBold => heeboFont.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text10PxBold => heeboFont.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get text8pxBold => heeboFont.copyWith(
        fontSize: 8.sp,
        fontWeight: FontWeight.bold,
      );
}

double calculateSpacing(double em) {
  return 16 * em;
}
