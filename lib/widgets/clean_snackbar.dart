import 'package:another_flushbar/flushbar.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget rilFlushBar(BuildContext context, String text,
    {Color bgColor = AppColors.darkOutline50, Color textColor = AppColors
        .white, int? duration, bool isShimmer = false}) {
  return Flushbar(
    backgroundColor: bgColor,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.only(left: 30, right: 30, top: 40),
    borderRadius: BorderRadius.all(10.circular),
    isDismissible: true,
    duration: (duration ?? 3).seconds,
    // titleText: "Hello Hero".toText(color: AppColors.darkBg, medium: true, fontSize: 16),
    messageText: Shimmer.fromColors(
        baseColor: textColor,
        highlightColor: isShimmer ? AppColors.darkOutline50 : textColor,
        child: text.toText(color: textColor, medium: true, fontSize: 14)),
  )
    ..show(context);
}

cleanSnack(BuildContext context, {
  required String text,
  Color? color,
  Color? textColor,
  int sec = 3,
  SnackBarAction? customAction,
  bool showSnackAction = true,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    duration: sec.seconds,
    behavior: SnackBarBehavior.floating,
    backgroundColor: color ?? AppColors.darkGrey,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: textColor ?? AppColors.greyLight, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    action: showSnackAction
        ? (customAction ??
        SnackBarAction(
          label: 'close',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ))
        : SnackBarAction(
      label: '',
      onPressed: () {},
    ),
  ));
}
